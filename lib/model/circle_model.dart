class CircleModel {
  final int radius;

  CircleModel({required this.radius});

  double calculateArea() {
    return radius * radius * 3.14;
  }
}
