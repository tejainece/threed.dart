import 'dart:math' as math;
import 'package:threed/src/core/core.dart';
import 'package:threed/src/core/matrix4.dart';

abstract class EulerOrder {
  static const xyz = 'XYZ';

  static const yzx = 'YZX';

  static const zxy = 'ZXY';

  static const xzy = 'XZY';

  static const yxz = 'YXZ';

  static const zyx = 'ZYX';

  static const defaultOrder = xyz;
}

class Euler {
  double x = 0;

  double y = 0;

  double z = 0;

  String order = EulerOrder.defaultOrder;

  Euler(
      {this.x = 0,
      this.y = 0,
      this.z = 0,
      this.order = EulerOrder.defaultOrder});

  factory Euler.from(Iterable<num> array,
      [String order = EulerOrder.defaultOrder]) {
    if (array.length < 3) {
      throw Exception("Must contain atleast 3 components");
    }
    return Euler(
        x: array.elementAt(0).toDouble(),
        y: array.elementAt(1).toDouble(),
        z: array.elementAt(2).toDouble(),
        order: order);
  }

  factory Euler.fromVector3(Vector3 other,
          [String order = EulerOrder.defaultOrder]) =>
      Euler(x: other.x, y: other.y, z: other.z, order: order);

  factory Euler.copy(Euler other) =>
      Euler(x: other.x, y: other.y, z: other.z, order: other.order);

  Euler get clone => Euler.copy(this);

  set assign(/* Euler | Vector3 | Iterable */ other) {
    if (other is Iterable<num>) {
      other = Euler.from(other);
    } else if (other is Vector3) {
      other = Euler.fromVector3(other);
    }

    if (other is Euler) {
      this.x = other.x;
      this.y = other.y;
      this.z = other.z;
      this.order = other.order;
    } else {
      throw ArgumentError("Unexpected value");
    }
  }

  // TODO setFromRotationMatrix
  void setFromRotationMatrix(Matrix4 m, {String order, update}) {
    // assumes the upper 3x3 of m is a pure rotation matrix (i.e, unscaled)
    order = order ?? this.order;

    if (order == EulerOrder.xyz) {
      y = math.asin(m.a13.clamp(-1, 1));

      if (m.a13.abs() < 0.9999999) {
        x = math.atan2(-m.a23, m.a33);
        z = math.atan2(-m.a12, m.a11);
      } else {
        x = math.atan2(m.a32, m.a22);
        z = 0;
      }
    } else if (order == EulerOrder.yxz) {
      x = math.asin(m.a23.clamp(-1, 1));

      if (m.a23.abs() < 0.9999999) {
        y = math.atan2(m.a13, m.a33);
        z = math.atan2(m.a21, m.a22);
      } else {
        y = math.atan2(-m.a31, m.a11);
        z = 0;
      }
    } else if (order == EulerOrder.zxy) {
      x = math.asin(m.a32.clamp(-1, 1));

      if (m.a32.abs() < 0.9999999) {
        y = math.atan2(-m.a31, m.a33);
        z = math.atan2(-m.a12, m.a22);
      } else {
        y = 0;
        z = math.atan2(m.a21, m.a11);
      }
    } else if (order == EulerOrder.zyx) {
      y = math.asin(m.a31.clamp(-1, 1));

      if (m.a31.abs() < 0.9999999) {
        x = math.atan2(m.a32, m.a33);
        z = math.atan2(m.a21, m.a11);
      } else {
        x = 0;
        z = math.atan2(-m.a12, m.a22);
      }
    } else if (order == EulerOrder.yzx) {
      z = math.asin(m.a21.clamp(-1, 1));

      if (m.a21.abs() < 0.9999999) {
        x = math.atan2(-m.a23, m.a22);
        y = math.atan2(-m.a31, m.a11);
      } else {
        x = 0;
        y = math.atan2(m.a13, m.a33);
      }
    } else if (order == EulerOrder.xzy) {
      z = math.asin(m.a12.clamp(-1, 1));

      if (m.a12.abs() < 0.9999999) {
        x = math.atan2(m.a32, m.a22);
        y = math.atan2(m.a13, m.a11);
      } else {
        x = math.atan2(-m.a23, m.a33);
        y = 0;
      }
    } else {
      throw ArgumentError.value(order, 'order', 'Invalid value!');
    }

    this.order = order;
  }

  // TODO setFromQuaternion

  bool operator ==(Object other) {
    if (other is Euler) {
      return this.x == other.x &&
          this.y == other.y &&
          this.z == other.z &&
          this.order == other.order;
    }
    return false;
  }
}
