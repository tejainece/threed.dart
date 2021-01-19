import 'package:threed/src/core/frustrum.dart';
import 'package:threed/src/core/matrix4.dart';
import 'package:threed/src/object/geometry/geometry.dart';
import 'package:threed/src/object/material/material.dart';
import 'package:threed/threed.dart';

abstract class Object3D implements Something {
  String get name;

  Vector3 get position;

  bool get visible;

  Matrix4 get localMatrix;

  // TODO translation

  // TODO rotation

  // TODO scale

  // TODO normal
}

class Group implements Object3D {
  String name;

  Vector3 position;

  final children = <Object3D>[];

  bool visible = true;

  bool sortObjects = true;

  Matrix4 _localMatrix;

  Matrix4 get localMatrix => _localMatrix;
}

class MeshObject implements Object3D {
  String name;

  Vector3 position;

  bool visible = true;

  bool castShadow = false;

  bool frustrumCulled = true;

  Geometry geometry;

  Material material;

  MeshDrawMode drawMode = MeshDrawMode.triangles;

  Matrix4 _localMatrix;

  Matrix4 get localMatrix => _localMatrix;

  // TODO
}

enum MeshDrawMode {
  triangles,
  triangleFan,
  trianglesStrip,
}
