import 'package:flutter/material.dart';
import '../models/libro.dart';
import '../services/libro_service.dart';

class EditarLibroModal extends StatefulWidget {
  final Libro libro;

  EditarLibroModal({required this.libro});

  @override
  _EditarLibroModalState createState() => _EditarLibroModalState();
}

class _EditarLibroModalState extends State<EditarLibroModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _autorController;
  late TextEditingController _isbnController;
  late TextEditingController _cantidadController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.libro.titulo);
    _autorController = TextEditingController(text: widget.libro.autor);
    _isbnController = TextEditingController(text: widget.libro.isbn);
    _cantidadController = TextEditingController(text: widget.libro.cantidad.toString());
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _autorController.dispose();
    _isbnController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _updateLibro() async {
    if (_formKey.currentState!.validate()) {
      Libro updatedLibro = Libro(
        librosId: widget.libro.librosId,
        titulo: _tituloController.text,
        autor: _autorController.text,
        isbn: _isbnController.text,
        cantidad: int.parse(_cantidadController.text),
      );

      try {
        await LibroService().updateLibro(updatedLibro);
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el libro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Libro'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _autorController,
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un autor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingrese un ISBN';
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
                    return 'Por favor, ingrese una cantidad';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _updateLibro,
          child: Text('Actualizar'),
        ),
      ],
    );
  }
}
