class PalindromeNumberModel {
  final int number;

  PalindromeNumberModel({required this.number});

  bool checkPalindrome() {
    int num = number;
    int original = number;
    int reversed = 0;

    while (num > 0) {
      int digit = num % 10;
      reversed = reversed * 10 + digit;
      num ~/= 10;
    }

    bool isPalindrome = (original == reversed);

    return isPalindrome;
  }
}
