import 'package:threed/src/object/geometry/attribute.dart';
import 'dart:typed_data' as typed_data;

import 'package:threed/src/core/core.dart';
import 'package:threed/src/core/vector4.dart';

class Float32Attribute implements Attribute<typed_data.Float32List> {
  final typed_data.Float32List _data;

  final int instanceSize;

  String name;

  Float32Attribute._(this._data, this.instanceSize, {this.name});

  factory Float32Attribute(Iterable<double> data, int instanceSize,
      {String name}) {
    return Float32Attribute._(
        typed_data.Float32List.fromList(data), instanceSize,
        name: name);
  }

  factory Float32Attribute.aquire(typed_data.Float32List data, int instanceSize,
      {String name}) {
    return Float32Attribute._(data, instanceSize, name: name);
  }

  int get count => _data.length ~/ instanceSize;

  typed_data.Float32List operator [](int index) {
    return _data.buffer.asFloat32List(instanceSize * index, instanceSize);
  }

  void operator []=(int index, Iterable value) {
    int j = index * instanceSize;
    for (int i = 0; i < instanceSize; i++, j++) {
      _data[j] = value.elementAt(i);
    }
  }

  Vector3 vector3(int index, {bool normalize}) {
    index = index * instanceSize;

    return Vector3(x: _data[index], y: _data[index], z: _data[index]);
  }

  Vector4 vector4(int index, {bool normalize}) {
    index = index * instanceSize;

    return Vector4(
        x: _data[index], y: _data[index], z: _data[index], w: _data[index]);
  }
}
