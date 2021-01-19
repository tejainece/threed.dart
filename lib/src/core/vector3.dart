class Vector3 {
  double x = 0;
  double y = 0;
  double z = 0;

  Vector3({this.x = 0, this.y = 0, this.z = 0});

  factory Vector3.from(Iterable<num> array) {
    if (array.length < 3) {
      throw Exception("Must contain atleast 3 components");
    }
    return Vector3(
        x: array.elementAt(0).toDouble(),
        y: array.elementAt(1).toDouble(),
        z: array.elementAt(2).toDouble());
  }

  factory Vector3.same(num v) =>
      Vector3(x: v.toDouble(), y: v.toDouble(), z: v.toDouble());

  factory Vector3.copy(Vector3 other) =>
      Vector3(x: other.x, y: other.y, z: other.z);

  Vector3 get clone => Vector3.copy(this);

  void copyFrom(Vector3 other) {
    this.x = other.x;
    this.y = other.y;
    this.z = other.z;
  }

  void set({double x, double y, double z}) {
    if (x != null) this.x = x;
    if (y != null) this.y = y;
    if (z != null) this.z = z;
  }

  set assign(/* Vector3 | double | Iterable */ other) {
    if (other is Iterable<num>) {
      other = Vector3.from(other);
    } else if (other is num) other = Vector3.same(other);

    if (other is Vector3) {
      this.x = other.x;
      this.y = other.y;
      this.z = other.z;
    } else {
      throw ArgumentError("Unexpected value");
    }
  }

  bool operator ==(Object other) {
    if (other is Vector3) {
      return this.x == other.x && this.y == other.y && this.z == other.z;
    }
    return false;
  }

  Vector3 operator +(Vector3 other) =>
      Vector3(x: this.x + other.x, y: this.y + other.y, z: this.z + other.z);

  void add(Vector3 other) {
    this.x += other.x;
    this.y += other.y;
    this.z += other.z;
  }

  Vector3 operator -(Vector3 other) =>
      Vector3(x: this.x - other.x, y: this.y - other.y, z: this.z - other.z);

  void sub(Vector3 other) {
    this.x -= other.x;
    this.y -= other.y;
    this.z -= other.z;
  }

  Vector3 operator *(Vector3 other) =>
      Vector3(x: this.x * other.x, y: this.y * other.y, z: this.z * other.z);

  void mul(Vector3 other) {
    this.x *= other.x;
    this.y *= other.y;
    this.z *= other.z;
  }

  Vector3 operator -() => Vector3(x: -this.x, y: -this.y, z: -this.z);

  double dot(Vector3 other) =>
      this.x * other.x + this.y * other.y + this.z * other.z;

  // TODO euler

  // TODO axis angle

  // TODO matrix3

  // TODO matrix4

  void ceil() {
    this.x = this.x.ceilToDouble();
    this.y = this.y.ceilToDouble();
    this.z = this.z.ceilToDouble();
  }

  void floor() {
    this.x = this.x.floorToDouble();
    this.y = this.y.floorToDouble();
    this.z = this.z.floorToDouble();
  }

  void round() {
    this.x = this.x.roundToDouble();
    this.y = this.y.roundToDouble();
    this.z = this.z.roundToDouble();
  }

  List<double> get toList => [x, y, z];

  String toString() => 'Vector3($x, $y, $z)';
}
