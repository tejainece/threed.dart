import 'package:threed/src/object/geometry/attribute.dart';

abstract class Geometry {
  Attribute get positionAttribute;

  Attribute get normalAttribute;

  Attribute get colorAttribute;

  Attribute get uvAttribute;

  Attribute get uv2Attribute;

  // TODO morph attributes

  // TODO skin attribute

  // TODO vertices

  // TODO colors

  Attribute operator[](String name);

  void operator[]=(String name, Attribute attribute);

  void forEach(void forEachAttribute(String name, Attribute attribute));
}

Geometry cube() => null;

Geometry sphere() => null;

Geometry cylinder() => null;

class CubeGeometry implements Geometry {

}
