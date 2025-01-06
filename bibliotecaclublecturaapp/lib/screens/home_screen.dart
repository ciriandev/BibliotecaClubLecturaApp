import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biblioteca Club de Lectura'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de Libros (lo implementaremos más adelante)
              },
              child: Text('Libros'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla de Usuarios (lo implementaremos más adelante)
              },
              child: Text('Usuarios'),
            ),
          ],
        ),
      ),
    );
  }
}