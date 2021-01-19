import 'package:threed/src/object/object.dart';

abstract class Light implements Object3D {
  bool get canCastShadow;
}