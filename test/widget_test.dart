import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_splash_screen/main.dart';

void main() {
  testWidgets('Launch completes and can be replayed', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Let’s begin'), findsOneWidget);
    await tester.ensureVisible(find.text('Let’s begin'));
    await tester.tap(find.text('Let’s begin'));
    await tester.pump();
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Welcome to\nyour orbit.'), findsOneWidget);
    await tester.ensureVisible(find.text('Experience it again'));
    await tester.tap(find.text('Experience it again'));
    await tester.pump();
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('Experience it again'), findsOneWidget);
  });

  testWidgets('Fits a narrow phone with large text', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(1.5)),
          child: OrbitScreen(),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
