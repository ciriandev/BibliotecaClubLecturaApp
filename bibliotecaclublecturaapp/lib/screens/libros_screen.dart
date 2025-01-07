import 'package:bibliotecaclublecturaapp/models/libro.dart';
import 'package:flutter/material.dart';
import 'package:bibliotecaclublecturaapp/services/libro_service.dart';

class LibrosScreen extends StatefulWidget {
  @override
  _LibrosScreenState createState() => _LibrosScreenState();
}

class _LibrosScreenState extends State<LibrosScreen> {
  late Future<List<Libro>> futureLibros;

  @override
  void initState() {
    super.initState();
    futureLibros = LibroService().fetchLibros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Libros'),
      ),
      body: FutureBuilder<List<Libro>>(
        future: futureLibros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay libros disponibles.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var libro = snapshot.data![index];
                return ListTile(
                  title: Text(libro.titulo),
                  subtitle: Text('Autor: ${libro.autor}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}