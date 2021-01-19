import 'package:threed/src/object/geometry/attribute.dart';
import 'dart:typed_data' as typed_data;

import 'package:threed/src/core/core.dart';
import 'package:threed/src/core/vector4.dart';

class Uint16Attribute implements Attribute {
  final typed_data.Uint16List _data;

  final int instanceSize;

  String name;

  bool shouldNormalize = true;

  Uint16Attribute._(this._data, this.instanceSize,
      {this.name, this.shouldNormalize = true});

  factory Uint16Attribute(Iterable<int> data, int instanceSize,
      {String name, bool shouldNormalize}) {
    return Uint16Attribute._(typed_data.Uint16List.fromList(data), instanceSize,
        name: name, shouldNormalize: shouldNormalize);
  }

  factory Uint16Attribute.aquire(typed_data.Uint16List data, int instanceSize,
      {String name, bool shouldNormalize}) {
    return Uint16Attribute._(data, instanceSize,
        name: name, shouldNormalize: shouldNormalize);
  }

  int get count => _data.length ~/ instanceSize;

  typed_data.Uint16List operator [](int index) {
    return _data.buffer.asUint16List(instanceSize * index, instanceSize);
  }

  void operator []=(int index, Iterable value) {
    int j = index * instanceSize;
    for (int i = 0; i < instanceSize; i++, j++) {
      _data[j] = value.elementAt(i);
    }
  }

  Vector3 vector3(int index, {bool normalize}) {
    index = index * instanceSize;
    normalize ??= shouldNormalize;

    if (normalize) {
      return Vector3(
          x: _data[index] / uint16Max,
          y: _data[index + 1] / uint16Max,
          z: _data[index + 2] / uint16Max);
    } else {
      return Vector3(
          x: _data[index].toDouble(),
          y: _data[index].toDouble(),
          z: _data[index].toDouble());
    }
  }

  Vector4 vector4(int index, {bool normalize}) {
    index = index * instanceSize;
    normalize ??= shouldNormalize;

    if (normalize) {
      return Vector4(
          x: _data[index] / uint16Max,
          y: _data[index + 1] / uint16Max,
          z: _data[index + 2] / uint16Max,
          w: _data[index + 4] / uint16Max);
    } else {
      return Vector4(
          x: _data[index].toDouble(),
          y: _data[index].toDouble(),
          z: _data[index].toDouble(),
          w: _data[index].toDouble());
    }
  }

  // TODO color

  static const uint16Max = 65535;
}