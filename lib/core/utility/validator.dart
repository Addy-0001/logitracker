class Validators {
  Validators._();
  static String? emptyFieldValidator(String? value) =>
      (value ?? "").trim().isEmpty ? "Field Required" : null;

  static String? emailValidator(String? value) =>
      (value ?? "").trim().isEmpty ? "Field Required" : null;

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
