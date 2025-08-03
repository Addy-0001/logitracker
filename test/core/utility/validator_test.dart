// test/unit/core/utility/validator_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:logitracker/core/utility/validator.dart';

void main() {
  group('Validators', () {
    group('emptyFieldValidator', () {
      test('should return null for valid non-empty string', () {
        expect(Validators.emptyFieldValidator('test'), null);
      });

      test('should return error message for empty string', () {
        expect(Validators.emptyFieldValidator(''), 'Field Required');
      });

      test('should return error message for null value', () {
        expect(Validators.emptyFieldValidator(null), 'Field Required');
      });

      test('should return error message for whitespace only', () {
        expect(Validators.emptyFieldValidator('   '), 'Field Required');
      });
    });

    group('integerValidator', () {
      test('should return null for valid integer string', () {
        expect(Validators.integerValidator('123'), null);
      });

      test('should return error for invalid integer', () {
        expect(Validators.integerValidator('abc'), 'Invalid Value');
      });

      test('should return error for empty string', () {
        expect(Validators.integerValidator(''), 'Field Required');
      });
    });

    group('doubleValidator', () {
      test('should return null for valid double string', () {
        expect(Validators.doubleValidator('123.45'), null);
      });

      test('should return error for invalid double', () {
        expect(Validators.doubleValidator('abc'), 'Invalid Value');
      });
    });

    group('dateTimeValidator', () {
      test('should return null for valid DateTime', () {
        expect(Validators.dateTimeValidator(DateTime.now()), null);
      });

      test('should return error for null DateTime', () {
        expect(Validators.dateTimeValidator(null), 'Field Required');
      });
    });

    group('dropDownFieldValidator', () {
      test('should return null for valid dropdown value', () {
        expect(Validators.dropDownFieldValidator(1), null);
      });

      test('should return error for invalid dropdown value', () {
        expect(Validators.dropDownFieldValidator(0), 'Field Required');
      });
    });
  });
}
