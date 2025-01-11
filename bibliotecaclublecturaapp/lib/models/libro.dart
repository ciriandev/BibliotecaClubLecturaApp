// lib/models/libro.dart
class Libro {
  final int librosId;
  final String titulo;
  final String autor;
  final String isbn;
  final int cantidad;

  Libro({
    required this.librosId,
    required this.titulo,
    required this.autor,
    required this.isbn,
    required this.cantidad,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return Libro(
      librosId: json['librosId'],
      titulo: json['titulo'],
      autor: json['autor'],
      isbn: json['isbn'],
      cantidad: json['cantidad'],
    );
  }
}
