import 'dart:math' as math;

import 'package:threed/src/core/core.dart';

class Quaternion {
  double x = 0;

  double y = 0;

  double z = 0;

  double w = 0;

  Quaternion({this.w = 0, this.x = 0, this.y = 0, this.z = 0});

  factory Quaternion.from(Iterable<num> array) {
    if (array.length < 4) {
      throw Exception("Must contain atleast 4 components");
    }
    return Quaternion(
        w: array.elementAt(0).toDouble(),
        x: array.elementAt(1).toDouble(),
        y: array.elementAt(2).toDouble(),
        z: array.elementAt(3).toDouble());
  }

  factory Quaternion.fromVector3(Vector3 other) =>
      Quaternion(x: other.x, y: other.y, z: other.z);

  factory Quaternion.copy(Quaternion other) =>
      Quaternion(w: other.w, x: other.x, y: other.y, z: other.z);

  factory Quaternion.fromAxisAngle(Vector3 axis, double angleInRadians) {
    return Quaternion()..setFromAxisAngle(axis, angleInRadians);
  }

  factory Quaternion.fromEuler(Euler euler) =>
      Quaternion()..setFormEuler(euler);

  Quaternion get clone => Quaternion.copy(this);

  void copyFrom(Quaternion other) {
    this.w = other.w;
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }

  bool operator ==(Object other) {
    if (other is Quaternion) {
      return this.x == other.x &&
          this.y == other.y &&
          this.z == other.z &&
          this.w == other.w;
    }
    return false;
  }

  void set({double w, double x, double y, double z}) {
    if (w != null) this.w = w;
    if (x != null) this.x = x;
    if (y != null) this.y = y;
    if (z != null) this.z = z;
  }

  set assign(/* Quaternion | Vector3 | Iterable */ other) {
    if (other is Iterable<num>) {
      other = Quaternion.from(other);
    } else if (other is Vector3) {
      other = Quaternion.fromVector3(other);
    }

    if (other is Quaternion) {
      this.w = other.w;
      this.x = other.x;
      this.y = other.y;
      this.z = other.z;
    } else {
      throw ArgumentError("Unexpected value");
    }
  }

  void setFormEuler(Euler euler) {
    final x = euler.x, y = euler.y, z = euler.z, order = euler.order;

    // http://www.mathworks.com/matlabcentral/fileexchange/
    // 	20696-function-to-convert-between-dcm-euler-angles-quaternions-and-euler-vectors/
    //	content/SpinCalc.m

    final cos = math.cos;
    final sin = math.sin;

    final c1 = cos(x / 2);
    final c2 = cos(y / 2);
    final c3 = cos(z / 2);

    final s1 = sin(x / 2);
    final s2 = sin(y / 2);
    final s3 = sin(z / 2);

    if (order == EulerOrder.xyz) {
      this.x = s1 * c2 * c3 + c1 * s2 * s3;
      this.y = c1 * s2 * c3 - s1 * c2 * s3;
      this.z = c1 * c2 * s3 + s1 * s2 * c3;
      this.w = c1 * c2 * c3 - s1 * s2 * s3;
    } else if (order == EulerOrder.yxz) {
      this.x = s1 * c2 * c3 + c1 * s2 * s3;
      this.y = c1 * s2 * c3 - s1 * c2 * s3;
      this.z = c1 * c2 * s3 - s1 * s2 * c3;
      this.w = c1 * c2 * c3 + s1 * s2 * s3;
    } else if (order == EulerOrder.zxy) {
      this.x = s1 * c2 * c3 - c1 * s2 * s3;
      this.y = c1 * s2 * c3 + s1 * c2 * s3;
      this.z = c1 * c2 * s3 + s1 * s2 * c3;
      this.w = c1 * c2 * c3 - s1 * s2 * s3;
    } else if (order == EulerOrder.zyx) {
      this.x = s1 * c2 * c3 - c1 * s2 * s3;
      this.y = c1 * s2 * c3 + s1 * c2 * s3;
      this.z = c1 * c2 * s3 - s1 * s2 * c3;
      this.w = c1 * c2 * c3 + s1 * s2 * s3;
    } else if (order == EulerOrder.yzx) {
      this.x = s1 * c2 * c3 + c1 * s2 * s3;
      this.y = c1 * s2 * c3 + s1 * c2 * s3;
      this.z = c1 * c2 * s3 - s1 * s2 * c3;
      this.w = c1 * c2 * c3 - s1 * s2 * s3;
    } else if (order == EulerOrder.xzy) {
      this.x = s1 * c2 * c3 - c1 * s2 * s3;
      this.y = c1 * s2 * c3 - s1 * c2 * s3;
      this.z = c1 * c2 * s3 + s1 * s2 * c3;
      this.w = c1 * c2 * c3 + s1 * s2 * s3;
    }
  }

  void setFromAxisAngle(Vector3 axis, double angleInRadians) {
    final halfAngle = angleInRadians / 2;
    final s = math.sin(halfAngle);
    final c = math.cos(halfAngle);

    this.w = c;
    this.x = axis.x * s;
    this.y = axis.y * s;
    this.z = axis.z * s;
  }

  // TODO setFromRotationMatrix

  // TODO setFromUnitVectors

  Quaternion operator *(Quaternion other) {
    final w1 = this.w;
    final x1 = this.x;
    final y1 = this.y;
    final z1 = this.z;
    final w2 = other.w;
    final x2 = other.x;
    final y2 = other.y;
    final z2 = other.z;

    return Quaternion(
        w: w1 * w2 - x1 * x2 - y1 * y2 - z1 * z2,
        x: x1 * w2 + w1 * x2 + y1 * z2 - z1 * y2,
        y: y1 * w2 + w1 * y2 + z1 * x2 - x1 * z2,
        z: z1 * w2 + w1 * z2 + x1 * y2 - y1 * x2);
  }

  void mul(Quaternion other) {
    assign = this * other;
  }

  double dot(Quaternion other) =>
      this.x * other.x + this.y * other.y + this.z * other.z + this.w * other.w;

  List<double> get toList => [w, x, y, z];

  String toString() => 'Quaternion($w, $x, $y, $z)';
}
