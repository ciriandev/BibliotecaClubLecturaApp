import 'package:flutter/material.dart';
import 'libros_screen.dart'; // Asegúrate de importar la pantalla de libros

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
                // Navegar a la pantalla de Libros
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LibrosScreen()),
                );
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
