// lib/services/libro_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bibliotecaclublecturaapp/models/libro.dart';

class LibroService {
  final String baseUrl = 'http://192.168.1.40:5067/api/Libros';

  Future<List<Libro>> fetchLibros() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Libro> libros = body.map((dynamic item) => Libro.fromJson(item)).toList();
      return libros;
    } else {
      throw Exception('Failed to load libros');
    }
  }
}