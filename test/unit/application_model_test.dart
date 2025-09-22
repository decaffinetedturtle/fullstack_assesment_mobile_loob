import 'package:flutter_test/flutter_test.dart';
import 'package:fullstack_assesment_mobile_loob/features/job_application/data/models/application_model.dart';
import 'package:fullstack_assesment_mobile_loob/shared_widgets/status_card.dart';

void main() {
  group('JobApplication', () {
    test('should create JobApplication from valid JSON', () {
      final json = {
        'id': 'test-id',
        'full_name': 'John Doe',
        'phone_number': '+60123456789',
        'email': 'john@example.com',
        'position': 'Barista',
        'work_experience': '2 years in F&B',
        'status': 'applied',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
        'notes': 'Test notes',
      };

      final application = JobApplication.fromJson(json);

      expect(application.id, equals('test-id'));
      expect(application.fullName, equals('John Doe'));
      expect(application.phoneNumber, equals('+60123456789'));
      expect(application.email, equals('john@example.com'));
      expect(application.position, equals('Barista'));
      expect(application.workExperience, equals('2 years in F&B'));
      expect(application.status, equals(ApplicationStatus.applied));
      expect(application.notes, equals('Test notes'));
    });

    test('should create JobApplication from JSON without email and notes', () {
      final json = {
        'id': 'test-id',
        'full_name': 'Jane Doe',
        'phone_number': '+60123456789',
        'email': null,
        'position': 'Manager',
        'work_experience': '5 years experience',
        'status': 'screening',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
        'notes': null,
      };

      final application = JobApplication.fromJson(json);

      expect(application.email, isNull);
      expect(application.notes, isNull);
      expect(application.status, equals(ApplicationStatus.screening));
    });

    test('should convert JobApplication to JSON', () {
      final application = JobApplication(
        id: 'test-id',
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: 'john@example.com',
        position: 'Barista',
        workExperience: '2 years in F&B',
        status: ApplicationStatus.applied,
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-01-01T00:00:00Z'),
        notes: 'Test notes',
      );

      final json = application.toJson();

      expect(json['id'], equals('test-id'));
      expect(json['full_name'], equals('John Doe'));
      expect(json['phone_number'], equals('+60123456789'));
      expect(json['email'], equals('john@example.com'));
      expect(json['position'], equals('Barista'));
      expect(json['work_experience'], equals('2 years in F&B'));
      expect(json['status'], equals('applied'));
      expect(json['notes'], equals('Test notes'));
    });

    test('should handle copyWith correctly', () {
      final original = JobApplication(
        id: 'test-id',
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: 'john@example.com',
        position: 'Barista',
        workExperience: '2 years in F&B',
        status: ApplicationStatus.applied,
        createdAt: DateTime.parse('2024-01-01T00:00:00Z'),
        updatedAt: DateTime.parse('2024-01-01T00:00:00Z'),
        notes: 'Original notes',
      );

      final updated = original.copyWith(
        status: ApplicationStatus.screening,
        notes: 'Updated notes',
      );

      expect(updated.status, equals(ApplicationStatus.screening));
      expect(updated.notes, equals('Updated notes'));
      expect(updated.fullName, equals('John Doe'));
      expect(updated.id, equals('test-id'));
    });
  });

  group('ApplicationForm', () {
    test('should create ApplicationForm with all fields', () {
      final form = ApplicationForm(
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: 'john@example.com',
        position: 'Barista',
        workExperience: '2 years in F&B',
      );

      expect(form.fullName, equals('John Doe'));
      expect(form.phoneNumber, equals('+60123456789'));
      expect(form.email, equals('john@example.com'));
      expect(form.position, equals('Barista'));
      expect(form.workExperience, equals('2 years in F&B'));
    });

    test('should create ApplicationForm without email', () {
      final form = ApplicationForm(
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: null,
        position: 'Barista',
        workExperience: '2 years in F&B',
      );

      expect(form.email, isNull);
    });

    test('should convert ApplicationForm to JSON with email', () {
      final form = ApplicationForm(
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: 'john@example.com',
        position: 'Barista',
        workExperience: '2 years in F&B',
      );

      final json = form.toJson();

      expect(json['full_name'], equals('John Doe'));
      expect(json['phone_number'], equals('+60123456789'));
      expect(json['email'], equals('john@example.com'));
      expect(json['position'], equals('Barista'));
      expect(json['work_experience'], equals('2 years in F&B'));
    });

    test('should convert ApplicationForm to JSON without email', () {
      final form = ApplicationForm(
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: null,
        position: 'Barista',
        workExperience: '2 years in F&B',
      );

      final json = form.toJson();

      expect(json.containsKey('email'), isFalse);
    });

    test('should handle copyWith correctly', () {
      final original = ApplicationForm(
        fullName: 'John Doe',
        phoneNumber: '+60123456789',
        email: 'john@example.com',
        position: 'Barista',
        workExperience: '2 years in F&B',
      );

      final updated = original.copyWith(fullName: 'Jane Doe', email: null);

      expect(updated.fullName, equals('Jane Doe'));
      expect(updated.email, isNull);
      expect(updated.phoneNumber, equals('+60123456789'));
      expect(updated.position, equals('Barista'));
    });
  });

  group('ApplicationStatus parsing', () {
    test(
      'should parse different status strings correctly through fromJson',
      () {
        final appliedJson = {
          'id': '1',
          'full_name': 'Test',
          'phone_number': '+60123456789',
          'position': 'Test',
          'work_experience': 'Test',
          'status': 'applied',
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };
        final screeningJson = {
          'id': '1',
          'full_name': 'Test',
          'phone_number': '+60123456789',
          'position': 'Test',
          'work_experience': 'Test',
          'status': 'screening',
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };
        final interviewJson = {
          'id': '1',
          'full_name': 'Test',
          'phone_number': '+60123456789',
          'position': 'Test',
          'work_experience': 'Test',
          'status': 'interview',
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };
        final offerJson = {
          'id': '1',
          'full_name': 'Test',
          'phone_number': '+60123456789',
          'position': 'Test',
          'work_experience': 'Test',
          'status': 'offer',
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };
        final rejectedJson = {
          'id': '1',
          'full_name': 'Test',
          'phone_number': '+60123456789',
          'position': 'Test',
          'work_experience': 'Test',
          'status': 'rejected',
          'created_at': '2024-01-01T00:00:00Z',
          'updated_at': '2024-01-01T00:00:00Z',
        };

        expect(
          JobApplication.fromJson(appliedJson).status,
          equals(ApplicationStatus.applied),
        );
        expect(
          JobApplication.fromJson(screeningJson).status,
          equals(ApplicationStatus.screening),
        );
        expect(
          JobApplication.fromJson(interviewJson).status,
          equals(ApplicationStatus.interview),
        );
        expect(
          JobApplication.fromJson(offerJson).status,
          equals(ApplicationStatus.offer),
        );
        expect(
          JobApplication.fromJson(rejectedJson).status,
          equals(ApplicationStatus.rejected),
        );
      },
    );

    test('should default to applied for unknown status', () {
      final unknownJson = {
        'id': '1',
        'full_name': 'Test',
        'phone_number': '+60123456789',
        'position': 'Test',
        'work_experience': 'Test',
        'status': 'unknown',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };
      final emptyJson = {
        'id': '1',
        'full_name': 'Test',
        'phone_number': '+60123456789',
        'position': 'Test',
        'work_experience': 'Test',
        'status': '',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      expect(
        JobApplication.fromJson(unknownJson).status,
        equals(ApplicationStatus.applied),
      );
      expect(
        JobApplication.fromJson(emptyJson).status,
        equals(ApplicationStatus.applied),
      );
    });

    test('should handle case insensitive status', () {
      final appliedJson = {
        'id': '1',
        'full_name': 'Test',
        'phone_number': '+60123456789',
        'position': 'Test',
        'work_experience': 'Test',
        'status': 'APPLIED',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };
      final screeningJson = {
        'id': '1',
        'full_name': 'Test',
        'phone_number': '+60123456789',
        'position': 'Test',
        'work_experience': 'Test',
        'status': 'Screening',
        'created_at': '2024-01-01T00:00:00Z',
        'updated_at': '2024-01-01T00:00:00Z',
      };

      expect(
        JobApplication.fromJson(appliedJson).status,
        equals(ApplicationStatus.applied),
      );
      expect(
        JobApplication.fromJson(screeningJson).status,
        equals(ApplicationStatus.screening),
      );
    });
  });
}
