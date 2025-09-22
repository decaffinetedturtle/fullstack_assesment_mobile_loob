// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fullstack_assesment_mobile_loob/main.dart';

void main() {
  testWidgets('App loads and shows home page', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TealiveCareersApp()));

    await tester.pumpAndSettle();

    expect(find.text('Tealive Careers'), findsOneWidget);
    expect(find.text('Apply for a Position'), findsOneWidget);
    expect(find.text('Check Application Status'), findsOneWidget);
  });
}
