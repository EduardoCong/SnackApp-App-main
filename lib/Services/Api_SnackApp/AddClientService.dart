// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class AddClient {
  final String apiUrl = "http://SnackApp.somee.com/api/Clientes";

  Future<bool> registerClient(String nombre, String apallido, String telefono,
      String email, String contrasena) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "nombre": nombre,
          "apellido": apallido,
          "telefono": telefono,
          "correoElectronico": email,
          "contrasena": contrasena
        }),
      );

      print('Response Body: ${response.statusCode}');
      print('Response Body: ${response.contentLength}');
      print('Response Body: ${response.headers}');
      print('Response Body: ${response.request}');

      if (response.statusCode == 307) {
        // Si es una redirección, puedes obtener la nueva URL desde la cabecera 'location'
        String newUrl = response.headers['location']!;
        print(newUrl);
      }

      if (response.statusCode == 201) {
        // Registro exitoso
        return true;
      } else {
        // Registro fallido
        return false;
      }
    } catch (e) {
      // Manejo de errores
      print('Error de registro: $e');
      return false;
    }
  }
  Future<Map<String, dynamic>?>   getClientById(int clientId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$clientId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Cliente encontrado, decodifica la respuesta JSON
        Map<String, dynamic> clientData = jsonDecode(response.body);
        return clientData;
      } else {
        // Cliente no encontrado o error en la solicitud
        return null;
      }
    } catch (e) {
      // Manejo de errores
      print('Error al obtener el cliente por ID: $e');
      return null;
    }
  }
}
