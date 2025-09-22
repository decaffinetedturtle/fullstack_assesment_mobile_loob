import 'package:flutter_test/flutter_test.dart';
import 'package:fullstack_assesment_mobile_loob/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validateRequired', () {
      test('should return null for valid non-empty string', () {
        final result = Validators.validateRequired('John Doe', 'Name');
        expect(result, isNull);
      });

      test('should return error message for null value', () {
        final result = Validators.validateRequired(null, 'Name');
        expect(result, equals('Name is required'));
      });

      test('should return error message for empty string', () {
        final result = Validators.validateRequired('', 'Name');
        expect(result, equals('Name is required'));
      });

      test('should return error message for whitespace-only string', () {
        final result = Validators.validateRequired('   ', 'Name');
        expect(result, equals('Name is required'));
      });
    });

    group('validateEmail', () {
      test('should return null for valid email', () {
        final result = Validators.validateEmail('test@example.com');
        expect(result, isNull);
      });

      test('should return null for empty string', () {
        final result = Validators.validateEmail('');
        expect(result, isNull);
      });

      test('should return null for null value', () {
        final result = Validators.validateEmail(null);
        expect(result, isNull);
      });

      test('should return error message for invalid email format', () {
        final result = Validators.validateEmail('invalid-email');
        expect(result, equals('Please enter a valid email address'));
      });

      test('should return error message for email without domain', () {
        final result = Validators.validateEmail('test@');
        expect(result, equals('Please enter a valid email address'));
      });
    });

    group('validatePhoneNumber', () {
      test('should return null for valid phone number', () {
        final result = Validators.validatePhoneNumber('+60123456789');
        expect(result, isNull);
      });

      test('should return null for phone number with spaces', () {
        final result = Validators.validatePhoneNumber('+60 12 345 6789');
        expect(result, isNull);
      });

      test('should return null for phone number with dashes', () {
        final result = Validators.validatePhoneNumber('+60-12-345-6789');
        expect(result, isNull);
      });

      test('should return error message for null value', () {
        final result = Validators.validatePhoneNumber(null);
        expect(result, equals('Phone number is required'));
      });

      test('should return error message for empty string', () {
        final result = Validators.validatePhoneNumber('');
        expect(result, equals('Phone number is required'));
      });

      test('should return error message for invalid phone format', () {
        final result = Validators.validatePhoneNumber('abc123');
        expect(result, equals('Please enter a valid phone number'));
      });
    });

    group('validateMinLength', () {
      test('should return null for string with sufficient length', () {
        final result = Validators.validateMinLength(
          'This is a long text',
          10,
          'Description',
        );
        expect(result, isNull);
      });

      test('should return null for string with exact minimum length', () {
        final result = Validators.validateMinLength(
          'Exactly 10',
          10,
          'Description',
        );
        expect(result, isNull);
      });

      test('should return error message for string shorter than minimum', () {
        final result = Validators.validateMinLength('Short', 10, 'Description');
        expect(result, equals('Description must be at least 10 characters'));
      });

      test('should return error message for null value', () {
        final result = Validators.validateMinLength(null, 10, 'Description');
        expect(result, equals('Description is required'));
      });

      test('should return error message for empty string', () {
        final result = Validators.validateMinLength('', 10, 'Description');
        expect(result, equals('Description is required'));
      });
    });
  });
}
