import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.1.40:5067/api';  // Asegúrate de cambiar esta URL si es necesario.

  Future<List<dynamic>> getDonaciones() async {
    final response = await http.get(Uri.parse('$baseUrl/libros'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load donaciones');
    }
  }
}