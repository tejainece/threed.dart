import 'dart:html';

import 'package:threed/src/camera/camera.dart';
import 'package:threed/src/object/geometry/geometry.dart';
import 'package:threed/src/object/object.dart';
import 'package:threed/src/object/scene.dart';
import 'package:threed/src/renderer/renderer.dart';

void main() {
  querySelector('#output').text = 'Your Dart app is running.';

  final scene = Scene()
    ..children.add(Group()
      ..children.add(MeshObject()..meshes.add(Mesh(geometry: cube()))));
  final camera = Camera();

  final renderer = WebglRenderer(scene, camera);

  // TODO requestAnimationFrame
  renderer.render();
}
