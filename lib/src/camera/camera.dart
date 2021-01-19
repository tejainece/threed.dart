import 'package:threed/src/core/core.dart';
import 'package:threed/src/core/matrix4.dart';
import 'package:threed/src/object/object.dart';

class Camera implements Object3D {
  String name;

  Vector3 position;

  bool visible;

  Matrix4 projectionMatrix;

  Matrix4 matrixWorldInverse;

  Matrix4 _localMatrix;

  Matrix4 get localMatrix => _localMatrix;
}