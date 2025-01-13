import 'package:flutter/material.dart';
import 'package:bibliotecaclublecturaapp/models/libro.dart';
import 'package:bibliotecaclublecturaapp/services/libro_service.dart';
import 'package:bibliotecaclublecturaapp/screens/libro_detalle_screen.dart';
import 'package:bibliotecaclublecturaapp/widget/add_libro_form.dart'; // Importa el formulario

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

  // Método para refrescar la lista de libros después de añadir uno nuevo
  void _refreshLibros() {
    setState(() {
      futureLibros = LibroService().fetchLibros();
    });
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
                  leading: Image.network(
                    'https://covers.openlibrary.org/b/isbn/${libro.isbn}-S.jpg',
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(libro.titulo),
                  subtitle: Text('Autor: ${libro.autor}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LibroDetalleScreen(libro: libro),
                      ),
                    ).then((_) {
                      _refreshLibros(); // Refrescar después de volver
                    });
                  },

                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: AddBookForm(),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
