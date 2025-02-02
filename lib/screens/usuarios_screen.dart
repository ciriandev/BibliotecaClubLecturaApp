import 'package:flutter/material.dart';
import 'package:bibliotecaclublecturaapp/models/usuario.dart';
import 'package:bibliotecaclublecturaapp/services/usuarios_service.dart';

class UsuariosScreen extends StatefulWidget {
  @override
  _UsuariosScreenState createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  late Future<List<Usuario>> futureUsuarios;

  @override
  void initState() {
    super.initState();
    futureUsuarios = UsuarioService().fetchUsuarios();
  }

  void _openAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Añadir Usuario'),
          content: AddUserForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay usuarios disponibles.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var usuario = snapshot.data![index];
                return ListTile(
                  title: Text('${usuario.nombre} ${usuario.apellido}', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${usuario.email}'),
                      Text('Teléfono: ${usuario.telefono}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddUserDialog,
        child: Icon(Icons.add),
        tooltip: 'Añadir Usuario',
      ),
    );
  }
}

class AddUserForm extends StatefulWidget {
  @override
  _AddUserFormState createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  void _addUser() async {
  if (_formKey.currentState!.validate()) {
    Usuario newUsuario = Usuario(
      usuariosid: 0, // Este valor no es relevante, ya que será generado por el backend
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      email: _emailController.text,
      telefono: _telefonoController.text,
    );

    try {
      await UsuarioService().addUsuario(newUsuario);
      Navigator.of(context).pop(); // Cierra el diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario añadido exitosamente')),
      );
      setState(() {
        var futureUsuarios = UsuarioService().fetchUsuarios(); // Refresca la lista de usuarios
      });
    } catch (e) {
      Navigator.of(context).pop(); // Cierra el diálogo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al añadir el usuario')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa el nombre';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _apellidoController,
              decoration: InputDecoration(labelText: 'Apellido'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa el apellido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Por favor, ingresa un email válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(labelText: 'Teléfono'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa el teléfono';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addUser,
              child: Text('Añadir Usuario'),
            ),
          ],
        ),
      ),
    );
  }
}

