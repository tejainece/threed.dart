import 'dart:typed_data' as typed_data;
import 'dart:math' as math;

import 'package:threed/src/core/core.dart';
import 'package:threed/src/core/vector4.dart';

export 'float32_attribute.dart';
export 'uint16_attribute.dart';

abstract class Attribute<E extends typed_data.TypedData> {
  int get count;

  E operator [](int index);

  void operator []=(int index, Iterable value);

  Vector3 vector3(int index, {bool normalize});

  Vector4 vector4(int index, {bool normalize});
}

