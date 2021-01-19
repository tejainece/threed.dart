import 'dart:typed_data';

class Vector4 {
  final elements = Float64List(4);

  Vector4({double x = 0, double y = 0, double z = 0, double w = 0}) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
  }

  factory Vector4.from(Iterable<num> array) {
    if (array.length < 4) {
      throw Exception("Must contain atleast 4 components");
    }
    return Vector4(
        x: array.elementAt(0).toDouble(),
        y: array.elementAt(1).toDouble(),
        z: array.elementAt(2).toDouble(),
        w: array.elementAt(3).toDouble());
  }

  factory Vector4.same(num v) => Vector4(
      x: v.toDouble(), y: v.toDouble(), z: v.toDouble(), w: v.toDouble());

  factory Vector4.copy(Vector4 other) =>
      Vector4(x: other.x, y: other.y, z: other.z, w: other.w);

  double get x => elements[0];

  set x(double v) => elements[0] = v;

  double get y => elements[1];

  set y(double v) => elements[1] = v;

  double get z => elements[2];

  set z(double v) => elements[2] = v;

  double get w => elements[3];

  set w(double v) => elements[3] = v;

  double operator [](int index) => elements[index];

  void operator []=(int index, double v) => elements[index] = v;
}
