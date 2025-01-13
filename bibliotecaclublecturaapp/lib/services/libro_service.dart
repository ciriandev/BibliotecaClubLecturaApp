import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/libro.dart';

class LibroService {
  final String baseUrl = 'http://192.168.1.40:5067/api';

  Future<List<Libro>> fetchLibros() async {
    final response = await http.get(Uri.parse('$baseUrl/libros'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Libro.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load libros');
    }
  }

  Future<void> addLibro(Libro libro) async {
    final response = await http.post(
      Uri.parse('$baseUrl/libros'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(libro.toJson()),
    );

    if (response.statusCode == 201) {
      print('Libro añadido con éxito.');
    } else {
      throw Exception('Failed to add libro.');
    }
  }

  Future<void> updateLibro(Libro libro) async {
    final response = await http.put(
      Uri.parse('$baseUrl/libros/${libro.librosId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(libro.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update libro.');
    }
  }

  Future<void> deleteLibro(int? id) async {
    if (id == null) {
      throw Exception('El ID del libro no puede ser null.');
    }

    final response = await http.delete(
      Uri.parse('$baseUrl/libros/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete libro.');
    }
  }
}
