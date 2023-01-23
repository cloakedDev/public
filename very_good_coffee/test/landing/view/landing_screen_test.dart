import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee/landing/view/landing_screen.dart';
import 'package:very_good_coffee/landing/widgets/landing_body.dart';
import '../../helpers/pump_app.dart';

void main() {
  group('LandingScreen', () {
    testWidgets('renders landing view', (tester) async {
      await tester.pumpApp(const LandingScreen());
      expect(find.byType(LandingView), findsOneWidget);
    });
  });
  group('LandingBackground', () {
    testWidgets('renders background', (tester) async {
      await tester.pumpApp(const LandingView());
      expect(find.byKey(const Key('landingScreen_background')), findsOneWidget);
    });
  });
  group('LandingBody', () {
    testWidgets('renders body', (tester) async {
      await tester.pumpApp(const LandingBody());
      expect(find.byKey(const Key('landing_Body')), findsOneWidget);
    });
  });
}
