import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack_assesment_mobile_loob/main.dart';

void main() {
  group('Application Page Integration Tests', () {
    testWidgets('should display application form with all required fields', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      expect(find.text('Join Our Team'), findsOneWidget);
      expect(find.text('Apply for a position at Tealive'), findsOneWidget);
      expect(find.text('Full Name *'), findsOneWidget);
      expect(find.text('Phone Number *'), findsOneWidget);
      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('Position Applied For *'), findsOneWidget);
      expect(find.text('Work Experience *'), findsOneWidget);
      expect(find.text('Submit Application'), findsOneWidget);
    });

    testWidgets('should show validation errors for empty required fields', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Full Name is required'), findsOneWidget);
      expect(find.text('Phone number is required'), findsOneWidget);
      expect(find.text('Position is required'), findsOneWidget);
      expect(find.text('Work Experience is required'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid phone number', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(1), 'invalid-phone');
      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid phone number'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid email', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(2), 'invalid-email');
      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets(
      'should show validation error for work experience that is too short',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const ProviderScope(child: TealiveCareersApp()),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Apply for a Position'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFormField).at(4), 'Short');
        await tester.tap(find.text('Submit Application'));
        await tester.pumpAndSettle();

        expect(
          find.text('Work Experience must be at least 10 characters'),
          findsOneWidget,
        );
      },
    );

    testWidgets('should allow form submission with valid data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextFormField).at(1), '+60123456789');
      await tester.enterText(
        find.byType(TextFormField).at(2),
        'john@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(3), 'Barista');
      await tester.enterText(
        find.byType(TextFormField).at(4),
        'I have 2 years of experience in the food and beverage industry.',
      );

      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Full Name is required'), findsNothing);
      expect(find.text('Phone number is required'), findsNothing);
      expect(find.text('Position is required'), findsNothing);
      expect(find.text('Work Experience is required'), findsNothing);
    });

    testWidgets('should allow form submission without email', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'Jane Doe');
      await tester.enterText(find.byType(TextFormField).at(1), '+60123456789');
      await tester.enterText(find.byType(TextFormField).at(3), 'Manager');
      await tester.enterText(
        find.byType(TextFormField).at(4),
        'I have 5 years of management experience in retail.',
      );

      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Full Name is required'), findsNothing);
      expect(find.text('Phone number is required'), findsNothing);
      expect(find.text('Position is required'), findsNothing);
      expect(find.text('Work Experience is required'), findsNothing);
    });

    testWidgets('should show loading state when submitting form', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextFormField).at(1), '+60123456789');
      await tester.enterText(find.byType(TextFormField).at(3), 'Barista');
      await tester.enterText(
        find.byType(TextFormField).at(4),
        'I have 2 years of experience in the food and beverage industry.',
      );

      await tester.tap(find.text('Submit Application'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Status Check Page Integration Tests', () {
    testWidgets('should display status check form', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      expect(find.text('Check Application Status'), findsOneWidget);
      expect(
        find.text('Enter your phone number to check your application status'),
        findsOneWidget,
      );
      expect(find.text('Phone Number *'), findsOneWidget);
      expect(find.text('Check Status'), findsOneWidget);
    });

    testWidgets('should show validation error for empty phone number', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Status'));
      await tester.pumpAndSettle();

      expect(find.text('Phone number is required'), findsOneWidget);
    });

    testWidgets('should show validation error for invalid phone number', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'invalid-phone');
      await tester.tap(find.text('Check Status'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid phone number'), findsOneWidget);
    });

    testWidgets('should allow status check with valid phone number', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), '+60123456789');
      await tester.tap(find.text('Check Status'));
      await tester.pumpAndSettle();

      expect(find.text('Phone number is required'), findsNothing);
      expect(find.text('Please enter a valid phone number'), findsNothing);
    });

    testWidgets('should show loading state when checking status', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), '+60123456789');
      await tester.tap(find.text('Check Status'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('Navigation Integration Tests', () {
    testWidgets('should navigate from home to application page and back', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      expect(find.text('Tealive Careers'), findsOneWidget);

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      expect(find.text('Join Our Team'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text('Tealive Careers'), findsOneWidget);
      expect(find.text('Join Our Team'), findsNothing);
    });

    testWidgets('should navigate from home to status page and back', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      expect(find.text('Tealive Careers'), findsOneWidget);

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      expect(find.text('Check Application Status'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text('Tealive Careers'), findsOneWidget);
      expect(find.text('Check Application Status'), findsNothing);
    });
  });
}
