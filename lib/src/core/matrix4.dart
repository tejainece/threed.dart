import 'dart:typed_data';

import 'package:threed/src/core/vector4.dart';

class Matrix4 {
  final elements = Float64List(4 * 4);

  Matrix4(
      {double a00 = 0,
      double a01 = 0,
      double a02 = 0,
      double a03 = 0,
      double a10 = 0,
      double a11 = 0,
      double a12 = 0,
      double a13 = 0,
      double a20 = 0,
      double a21 = 0,
      double a22 = 0,
      double a23 = 0,
      double a30 = 0,
      double a31 = 0,
      double a32 = 0,
      double a33 = 0,
      Iterable<double> a0,
      Iterable<double> a1,
      Iterable<double> a2,
      Iterable<double> a3,
      double a}) {
    if (a != 0) {
      assign = a;
      return;
    }

    if (a0 != null) {
      this[0] = a0;
    } else {
      elements[0] = a00;
      elements[1] = a01;
      elements[2] = a02;
      elements[3] = a03;
    }

    if (a1 != null) {
      this[1] = a1;
    } else {
      elements[4] = a10;
      elements[5] = a11;
      elements[6] = a12;
      elements[7] = a13;
    }

    if (a2 != null) {
      this[2] = a2;
    } else {
      elements[8] = a20;
      elements[9] = a21;
      elements[10] = a22;
      elements[11] = a23;
    }

    if (a3 != null) {
      this[3] = a3;
    } else {
      elements[12] = a30;
      elements[13] = a31;
      elements[14] = a32;
      elements[15] = a33;
    }
  }

  factory Matrix4.I() => Matrix4(a00: 1, a11: 1, a22: 1, a33: 1);

  double get a00 => elements[0];
  set a00(double value) => elements[0] = value;
  double get a01 => elements[1];
  set a01(double value) => elements[1] = value;
  double get a02 => elements[2];
  set a02(double value) => elements[2] = value;
  double get a03 => elements[3];
  set a03(double value) => elements[3] = value;
  double get a10 => elements[4];
  set a10(double value) => elements[4] = value;
  double get a11 => elements[5];
  set a11(double value) => elements[5] = value;
  double get a12 => elements[6];
  set a12(double value) => elements[6] = value;
  double get a13 => elements[7];
  set a13(double value) => elements[7] = value;
  double get a20 => elements[8];
  set a20(double value) => elements[8] = value;
  double get a21 => elements[9];
  set a21(double value) => elements[9] = value;
  double get a22 => elements[10];
  set a22(double value) => elements[10] = value;
  double get a23 => elements[11];
  set a23(double value) => elements[11] = value;
  double get a30 => elements[12];
  set a30(double value) => elements[12] = value;
  double get a31 => elements[13];
  set a31(double value) => elements[13] = value;
  double get a32 => elements[14];
  set a32(double value) => elements[14] = value;
  double get a33 => elements[15];
  set a33(double value) => elements[15] = value;
  
  Float64List operator [](int index) =>
      elements.buffer.asFloat64List(index * 4, 4);

  void operator []=(int index, Iterable<double> v) {
    final ite = v.iterator;
    int i = index * 4;
    elements[i++] = (ite..moveNext()).current;
    elements[i++] = (ite..moveNext()).current;
    elements[i++] = (ite..moveNext()).current;
    elements[i++] = (ite..moveNext()).current;
  }

  set assign(/* num | Iterable<num> | Vector4 */ value) {
    if (value is num) {
      value = value.toDouble();
      for (int i = 0; i < 16; i++) {
        elements[i] = value;
      }
      return;
    }
    if (value is Vector4) value = value.elements;
    if (value is Iterable<num>) {
      value = value.map((v) => v.toDouble());
      this[0] = value;
      this[1] = value;
      this[2] = value;
    }
    throw ArgumentError("Unkown value type!");
  }

  void setI() {
    a00 = 1;
    a01 = 0;
    a02 = 0;
    a03 = 0;
    a10 = 0;
    a11 = 1;
    a12 = 0;
    a13 = 0;
    a20 = 0;
    a21 = 0;
    a22 = 1;
    a23 = 0;
    a30 = 0;
    a31 = 0;
    a32 = 0;
    a33 = 1;
  }

  Matrix4 operator*(Matrix4 other) {
    // TODO
  }
}
