class Validators {
  Validators._();

  static String? emptyFieldValidator(String? value) =>
      (value ?? "").trim().isEmpty ? "Field Required" : null;

  static String? emailValidator(String? value) =>
      (value ?? "").trim().isEmpty ? "Field Required" : null;

  static String? phoneValidator(String? value) {
    if ((value ?? "").trim().isEmpty) {
      return "Field Required";
    }

    // Remove all non-digit characters for validation
    String phone = value!.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if it's a valid length (adjust based on your requirements)
    if (phone.length < 10) {
      return "Phone number must be at least 10 digits";
    }

    if (phone.length > 15) {
      return "Phone number cannot exceed 15 digits";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if ((value ?? "").trim().isEmpty) {
      return "Field Required";
    }
    if (value!.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if ((value ?? "").trim().isEmpty) {
      return "Field Required";
    }
    if (value != password) {
      return "Passwords don't match";
    }
    return null;
  }

  static String? integerValidator(String? value) =>
      (value ?? "").trim().isEmpty
          ? "Field Required"
          : (int.tryParse(value!.trim()) == null)
          ? "Invalid Value"
          : null;

  static String? doubleValidator(String? value) =>
      (value ?? "").trim().isEmpty
          ? "Field Required"
          : (double.tryParse(value!.trim()) == null)
          ? "Invalid Value"
          : null;

  static String? dateTimeValidator(DateTime? value) =>
      value == null ? "Field Required" : null;

  static String? dropDownFieldValidator(int? value) =>
      (value ?? 0) < 1 ? "Field Required" : null;
}
