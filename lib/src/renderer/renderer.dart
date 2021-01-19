import 'dart:web_gl' as webgl;

import 'package:threed/src/camera/camera.dart';
import 'package:threed/src/core/frustrum.dart';
import 'package:threed/src/core/matrix4.dart';
import 'package:threed/src/object/geometry/geometry.dart';
import 'package:threed/src/object/light/light.dart';
import 'package:threed/src/object/material/material.dart';
import 'package:threed/src/object/object.dart';
import 'package:threed/src/object/scene.dart';
import 'package:threed/src/renderer/webgl/program.dart';

abstract class Renderer {
  /// Renders the given scene with the given camera.
  void render();
}

class WebglRenderer implements Renderer {
  final Scene scene;

  final Camera camera;

  final webgl.RenderingContext2 context;

  WebglRenderer(this.context, this.scene, this.camera);

  WebglRenderList _renderList;

  LightList _lightList;

  Matrix4 _projScreenMatrix;

  Frustrum _frustrum;

  void render() {
    // TODO serialize calls

    _projScreenMatrix = camera.projectionMatrix * camera.matrixWorldInverse;
    _frustrum.setFromMatrix(_projScreenMatrix);

    // TODO update frustrum

    _projectObject(scene.group, Matrix4.I());
    if (scene.group.sortObjects) _renderList.sort();

    // TODO shadow
    _lightList.setupLights();

    // TODO render background

    for (final object in _renderList.items) {
      _renderMesh(object);
    }

    // TODO
  }

  /// Inserts the passed [object] and all its children into [_renderList].
  void _projectObject(final Object3D object, Matrix4 worldMatrix) {
    if (!object.visible) return;

    if (object is Group) {
      Matrix4 newWorldMatrix = worldMatrix * object.localMatrix;
      // TODO renderOrder

      for (final child in object.children) {
        _projectObject(child, newWorldMatrix);
      }
    }
    // TODO LOD
    else if (object is Light) {
      _lightList.add(object);
    }
    // TODO sprite
    else if (object is MeshObject) {
      // TODO isSkinnedMesh?

      if (!object.frustrumCulled || _frustrum.intersectsObject(object)) {
        // TODO sort objects

        // TODO update object

        if (object.material.visible) {
          _renderList.add(WebglRenderItem(
              object: object,
              worldMatrix:
                  worldMatrix * object.localMatrix)); // TODO pass sortobjects
        }
      }
    }
  }

  void _renderMesh(WebglRenderItem item) {
    final modelViewMatrix = camera.matrixWorldInverse * item.worldMatrix;
    // TODO normal matrix

    // TODO object with custom rendering (immediateRenderObject)
    // TODO

    final program = _setProgram(item);
    _setUniforms(program, item);
    _setAttributes(program, item);
    _draw(program, item);

    // TODO
  }

  WebglProgram _setProgram(WebglRenderItem item) {
    // TODO reset texture units

    // TODO clipping

    // TODO

    // initMaterial
    final program =
        item.material.buildProgram(context); // TODO cache program
    context.useProgram(program.program);

    return program;
  }

  void _setUniforms(WebglProgram program, WebglRenderItem item) {
    // TODO set projection matrix uniform

    // TODO set logarithmicDepthBuffer uniform

    // TODO set matrix camera world uniform

    // TODO set isOrthographic uniform

    // TODO
  }

  void _setAttributes(WebglProgram program, WebglRenderItem item) {

    // TODO

    context.enableVertexAttribArray(index);
    context.bindBuffer(target, buffer);
    context.vertexAttribPointer(indx, size, type, normalized, stride, offset);
  }

  void _draw(WebglProgram program, WebglRenderItem item) {
    int mode;

    if (item.object is MeshObject) {
      final MeshObject mesh = item.object;
      if (false /* TODO wireframe */) {
        // TODO
      } else {
        switch (mesh.drawMode) {
          case MeshDrawMode.triangles:
            {
              mode = webgl.WebGL.TRIANGLES;
            }
            break;
          case MeshDrawMode.triangleFan:
            {
              mode = webgl.WebGL.TRIANGLE_FAN;
            }
            break;
          case MeshDrawMode.trianglesStrip:
            {
              mode = webgl.WebGL.TRIANGLE_STRIP;
            }
            break;
        }
      }
    } else if (false /* object is Line */) {
      // TODO
    } else if (false /* object is Point */) {
      // TODO
    }

    // TODO indexed buffer

    // TODO instanced mesh
    // TODO instanced buffer geometry

    context.drawArrays(mode, 0, count);
  }
}

class WebglRenderList {
  final items = <WebglRenderItem>[];

  WebglRenderList();

  void add(WebglRenderItem item) {
    items.add(item);
  }

  void sort() {
    // TODO
  }
}

class WebglRenderItem<O extends Object3D> {
  final O object;

  final Matrix4 worldMatrix;

  // TODO

  WebglRenderItem({this.object, this.worldMatrix});
}

class LightList {
  final lights = <Light>[];
  final lightsWithShadow = <Light>[];

  void add(Light light) {
    lights.add(light);
    if (light.canCastShadow) {
      lightsWithShadow.add(light);
    }
  }

  void setupLights() {
    // TODO
  }
}
