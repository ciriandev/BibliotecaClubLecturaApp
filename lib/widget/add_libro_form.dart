import 'package:flutter/material.dart';
import 'package:bibliotecaclublecturaapp/services/libro_service.dart';
import 'package:bibliotecaclublecturaapp/models/libro.dart';

class AddBookForm extends StatefulWidget {
  final VoidCallback onBookAdded;

  AddBookForm({required this.onBookAdded});

  @override
  _AddBookFormState createState() => _AddBookFormState();
}

class _AddBookFormState extends State<AddBookForm> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _autorController = TextEditingController();
  final _isbnController = TextEditingController();
  final _cantidadController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Libro nuevoLibro = Libro(
        titulo: _tituloController.text,
        autor: _autorController.text,
        isbn: _isbnController.text,
        cantidad: int.parse(_cantidadController.text),
      );

      try {
        await LibroService().addLibro(nuevoLibro);
        widget.onBookAdded();
        Navigator.of(context).pop();
      } catch (e) {
        print('Error al añadir el libro: $e');
        // Mostrar un mensaje de error al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al añadir el libro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el título del libro';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _autorController,
              decoration: InputDecoration(labelText: 'Autor'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el autor del libro';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _isbnController,
              decoration: InputDecoration(labelText: 'ISBN'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa el ISBN del libro';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _cantidadController,
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa la cantidad de libros';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Añadir Libro'),
            ),
          ],
        ),
      ),
    );
  }
}
