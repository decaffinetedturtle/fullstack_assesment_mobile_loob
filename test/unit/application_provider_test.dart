import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack_assesment_mobile_loob/features/job_application/providers/application_provider.dart';

void main() {
  group('ApplicationFormNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with empty form', () {
      final form = container.read(applicationFormProvider);

      expect(form.fullName, equals(''));
      expect(form.phoneNumber, equals(''));
      expect(form.email, equals(''));
      expect(form.position, equals(''));
      expect(form.workExperience, equals(''));
    });

    test('should update full name', () {
      container
          .read(applicationFormProvider.notifier)
          .updateFullName('John Doe');

      final form = container.read(applicationFormProvider);
      expect(form.fullName, equals('John Doe'));
    });

    test('should update phone number', () {
      container
          .read(applicationFormProvider.notifier)
          .updatePhoneNumber('+60123456789');

      final form = container.read(applicationFormProvider);
      expect(form.phoneNumber, equals('+60123456789'));
    });

    test('should update email', () {
      container
          .read(applicationFormProvider.notifier)
          .updateEmail('john@example.com');

      final form = container.read(applicationFormProvider);
      expect(form.email, equals('john@example.com'));
    });

    test('should update position', () {
      container
          .read(applicationFormProvider.notifier)
          .updatePosition('Barista');

      final form = container.read(applicationFormProvider);
      expect(form.position, equals('Barista'));
    });

    test('should update work experience', () {
      container
          .read(applicationFormProvider.notifier)
          .updateWorkExperience('2 years experience');

      final form = container.read(applicationFormProvider);
      expect(form.workExperience, equals('2 years experience'));
    });

    test('should reset form to initial state', () {
      container
          .read(applicationFormProvider.notifier)
          .updateFullName('John Doe');
      container
          .read(applicationFormProvider.notifier)
          .updatePhoneNumber('+60123456789');
      container
          .read(applicationFormProvider.notifier)
          .updateEmail('john@example.com');
      container
          .read(applicationFormProvider.notifier)
          .updatePosition('Barista');
      container
          .read(applicationFormProvider.notifier)
          .updateWorkExperience('2 years experience');

      container.read(applicationFormProvider.notifier).reset();

      final form = container.read(applicationFormProvider);
      expect(form.fullName, equals(''));
      expect(form.phoneNumber, equals(''));
      expect(form.email, equals(''));
      expect(form.position, equals(''));
      expect(form.workExperience, equals(''));
    });
  });

  group('ApplicationSubmissionNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with null data', () {
      final state = container.read(applicationSubmissionProvider);

      expect(state.hasValue, isTrue);
      expect(state.value, isNull);
    });

    test('should reset to initial state', () {
      container.read(applicationSubmissionProvider.notifier).reset();

      final state = container.read(applicationSubmissionProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, isNull);
    });
  });

  group('ApplicationStatusNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should initialize with null data', () {
      final state = container.read(applicationStatusProvider);

      expect(state.hasValue, isTrue);
      expect(state.value, isNull);
    });

    test('should reset to initial state', () {
      container.read(applicationStatusProvider.notifier).reset();

      final state = container.read(applicationStatusProvider);
      expect(state.hasValue, isTrue);
      expect(state.value, isNull);
    });
  });
}
