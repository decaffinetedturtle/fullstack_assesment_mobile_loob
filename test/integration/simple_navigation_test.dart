import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullstack_assesment_mobile_loob/main.dart';

void main() {
  group('Simple Navigation Tests', () {
    testWidgets('should navigate from home to application page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      expect(find.text('Tealive Careers'), findsOneWidget);

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      expect(find.text('Join Our Team'), findsOneWidget);
      expect(find.text('Full Name *'), findsOneWidget);
    });

    testWidgets('should navigate from home to status page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      expect(find.text('Tealive Careers'), findsOneWidget);

      await tester.tap(find.text('Check Application Status'));
      await tester.pumpAndSettle();

      expect(find.text('Check Application Status'), findsOneWidget);
      expect(find.text('Phone Number *'), findsOneWidget);
    });

    testWidgets('should display form validation errors', (
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

    testWidgets('should validate email format', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).at(2);
      await tester.enterText(emailField, 'invalid-email');
      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('should validate phone number format', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      final phoneField = find.byType(TextFormField).at(1);
      await tester.enterText(phoneField, 'invalid-phone');
      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid phone number'), findsOneWidget);
    });

    testWidgets('should validate work experience minimum length', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Apply for a Position'));
      await tester.pumpAndSettle();

      final experienceField = find.byType(TextFormField).at(4);
      await tester.enterText(experienceField, 'Short');
      await tester.tap(find.text('Submit Application'));
      await tester.pumpAndSettle();

      expect(
        find.text('Work Experience must be at least 10 characters'),
        findsOneWidget,
      );
    });
  });
}
