import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000";

  // Registro de usuario
  Future<Map<String, dynamic>> registerUser(
    String email,
    String password,
    String nombre,
    String apellido,
    String direccion,
    String telefono,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/registro'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'nombre': nombre,
          'apellido': apellido,
          'direccion': direccion,
          'telefono': telefono,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Error en el registro: ${response.body}'};
      }
    } catch (e) {
      return {'error': 'Error al conectar con el servidor: $e'};
    }
  }

  // Login de usuario
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Error en el login: ${response.body}'};
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
      return {'error': 'Error al conectar con el servidor: $e'};
    }
  }

  // Cierre de sesión (borrar sesión local o notificar al servidor)
  Future<void> logoutUser() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'), // Si el backend requiere solicitud HTTP
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Sesión cerrada exitosamente');
      } else {
        print('Error en el logout: ${response.body}');
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
    }
  }
}
