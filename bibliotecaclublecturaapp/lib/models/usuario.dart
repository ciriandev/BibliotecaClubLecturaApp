class Usuario {
  final int usuariosid;
  final String nombre;
  final String apellido;
  final String email;
  final String telefono;

  Usuario({
    required this.usuariosid,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      usuariosid: json['usuariosId'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      telefono: json['telefono'],
    );
  }

  // Método toJson para convertir a formato JSON
  Map<String, dynamic> toJson() {
    return {
      'usuariosId': usuariosid,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'telefono': telefono,
    };
  }
}