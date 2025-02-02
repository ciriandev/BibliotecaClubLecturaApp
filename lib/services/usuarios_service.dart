import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  final String baseUrl = 'http://192.168.1.40:5067/api'; // Asegúrate de usar tu URL correcta

  Future<List<Usuario>> fetchUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Usuario.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load usuarios');
    }
  }

  Future<void> addUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuarios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add usuario');
    }
  }
}

