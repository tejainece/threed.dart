import 'package:threed/src/object/object.dart';

class Scene {
  Group group;

  List<Object3D> get children => group.children;
}