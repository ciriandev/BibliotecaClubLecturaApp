import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(BibliotecaApp());
}

class BibliotecaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca Club de Lectura',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
