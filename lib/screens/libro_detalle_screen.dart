import 'package:flutter/material.dart';
import 'package:bibliotecaclublecturaapp/models/libro.dart';
import 'package:bibliotecaclublecturaapp/services/libro_service.dart';
import '../widget/EditarLibroModal.dart';

class LibroDetalleScreen extends StatelessWidget {
  final Libro libro;

  LibroDetalleScreen({required this.libro});

  void _showEditModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditarLibroModal(libro: libro);
      },
    );
  }

  void _deleteLibro(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que deseas eliminar este libro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirm) {
      try {
        await LibroService().deleteLibro(libro.librosId);
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al eliminar el libro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(libro.titulo),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://covers.openlibrary.org/b/isbn/${libro.isbn}-M.jpg',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Título: ${libro.titulo}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Autor: ${libro.autor}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8.0),
            Text(
              'ISBN: ${libro.isbn}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Text(
              'Cantidad: ${libro.cantidad}',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showEditModal(context),
                  child: Text('Editar'),
                ),
                ElevatedButton(
                  onPressed: () => _deleteLibro(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

