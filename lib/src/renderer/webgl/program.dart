import 'package:meta/meta.dart';
import 'dart:web_gl';

/*
class WebglUniform {
  final webgl.ActiveInfo info;

  final webgl.UniformLocation location;

  WebglUniform(this.info, this.location);

  String get name => info.name;
}

class WebglUniforms {
  final LinkedHashMap<String, WebglUniform> uniforms;

  WebglUniforms(this.uniforms);
}

class WebglProgram {
  final WebglUniforms uniforms;

  WebglProgram(this.uniforms);

  factory WebglProgram.from(webgl.RenderingContext context, webgl.Program program) {
    int count = context.getProgramParameter(program, null /* TODO Active uniform */);

    final uniforms = LinkedHashMap<String, WebglUniform>();
    for(int i = 0; i < count; i++) {
      final info = context.getActiveUniform(program, i);
      final location = context.getUniformLocation(program, info.name);
      uniforms[info.name] = WebglUniform(info, location);
    }

    return WebglProgram(WebglUniforms(uniforms));
  }
}
 */

class WebglProgram {
  final RenderingContext2 context;

  final Shader vertex;

  final Shader fragment;

  final Program program;

  WebglProgram({this.context, this.vertex, this.fragment, this.program});

  factory WebglProgram.build(
      {@required RenderingContext2 context,
      @required String vertex,
      @required String fragment}) {
    // TODO Handle exceptions
    final vertexShader =
        compileShader(context, WebGL.VERTEX_SHADER, vertex);
    final fragmentShader =
        compileShader(context, WebGL.FRAGMENT_SHADER, fragment);
    final program = createProgram(context, vertexShader, fragmentShader);

    /* TODO
    final vao = context.createVertexArray();
    context.bindVertexArray(vao);
     */

    return WebglProgram(
      context: context,
      program: program,
      vertex: vertexShader,
      fragment: fragmentShader,
      // TODO vao: vao,
    );
  }

  void dispose() {
    context.deleteShader(vertex);
    context.deleteShader(fragment);
    context.deleteProgram(program);
  }

  static Shader compileShader(
      RenderingContext2 gl, int shaderType, String source) {
    Shader shader = gl.createShader(shaderType);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    final bool success =
        gl.getShaderParameter(shader, WebGL.COMPILE_STATUS);
    if (success) return shader;
    final msg = gl.getShaderInfoLog(shader);
    gl.deleteShader(shader);
    throw Exception("Compilation failed! ${msg}"); // TODO add message
  }

  static Program createProgram(RenderingContext2 context,
      Shader vertex, Shader fragment) {
    Program program = context.createProgram();
    context.attachShader(program, vertex);
    context.attachShader(program, fragment);
    context.linkProgram(program);
    var success = context.getProgramParameter(program, WebGL.LINK_STATUS);
    if (success) return program;

    // TODO console.log(gl.getProgramInfoLog(program));
    context.deleteProgram(program);

    throw Exception();
  }
}
