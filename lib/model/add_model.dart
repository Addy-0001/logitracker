class AddModel {
  final int first;
  final int second;

  AddModel({required this.first, required this.second});

  int add() {
    return first + second;
  }

  int sub() {
    return first - second;
  }
}
