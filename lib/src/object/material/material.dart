import 'dart:web_gl';

import 'package:threed/src/core/matrix4.dart';
import 'package:threed/src/renderer/webgl/program.dart';

class CommonUniforms {
  bool isOrthographic;

  // TODO camera position

  // TODO view matrix (camera world inverse)

  // TODO skinning uniforms

  // TODO receiveShadow

  // TODO toneMapping

  Matrix4 modelViewMatrix;

  Matrix4 normalMatrix;

  Matrix4 matrixWorld;
}

abstract class Material {
  bool get visible;

  WebglProgram buildProgram(RenderingContext2 context);

  void setUniforms(CommonUniforms uniforms);
}

