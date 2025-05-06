class SimpleInterestModel {
  final int p;
  final int t;
  final int r;

  SimpleInterestModel({required this.p, required this.t, required this.r});

  double calculateInterest() {
    return p * t * r / 100;
  }
}
