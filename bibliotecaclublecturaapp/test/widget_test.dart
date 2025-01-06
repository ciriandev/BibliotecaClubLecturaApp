// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bibliotecaclublecturaapp/main.dart';
import 'package:bibliotecaclublecturaapp/screens/home_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the "Libros" button is present.
    expect(find.text('Libros'), findsOneWidget);

    // Verify that the "Usuarios" button is present.
    expect(find.text('Usuarios'), findsOneWidget);

    // Verify that there are no other unexpected widgets.
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
}
