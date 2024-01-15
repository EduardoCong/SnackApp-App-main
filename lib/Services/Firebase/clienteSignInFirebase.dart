import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackapp/widgets/showSnackBar.dart';

class clienteSignIn {
  Future<bool?> login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user!.emailVerified) {
        print('Usuario autenticado y correo electrónico verificado');
        return true;
      } else {
        print('Correo electrónico no verificado');
        SnackBarWidget(
          backgroundColor: Colors.red,
          message:
              'Por favor, verifica tu correo electrónico para iniciar sesión.',
        ).showSnackBar(context);
        return false;
      }
    } on FirebaseAuthException catch (e) {
      // Manejar excepciones de Firebase aquí
      if (e.code == 'user-not-found') {
        SnackBarWidget(
          backgroundColor: Colors.red,
          message: 'No se encontró usuario con ese correo electrónico.',
        );
        print('No se encontró usuario con ese correo electrónico.');
      } else if (e.code == 'wrong-password') {
        SnackBarWidget(
          backgroundColor: Colors.red,
          message: 'Contraseña incorrecta para ese usuario.',
        ).showSnackBar(context);
        print('Contraseña incorrecta para ese usuario.');
      } else {
        // Muestra el mensaje de error genérico
        SnackBarWidget(
          backgroundColor: Colors.red,
          message: 'Error al iniciar sesión: ${e.message}',
        ).showSnackBar(context);
        print('Error al iniciar sesión: ${e.message}');
      }
      return null;
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      // Enviar correo electrónico de restablecimiento de contraseña
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print(
          'Correo electrónico de restablecimiento de contraseña enviado a $email');
      SnackBarWidget(
        backgroundColor: Color(0xCE1F5F07),
        message:
            'Correo electrónico de restablecimiento de contraseña enviado a ${email}',
      ).showSnackBar(context);
    } on FirebaseAuthException catch (e) {
      // Manejar errores de Firebase Authentication
      if (e.code == 'user-not-found') {
        // El usuario no fue encontrado
        print(
            'No se encontró un usuario con el correo electrónico proporcionado.');
      } else {
        // Otro error
        print(
            'Error al enviar el correo electrónico de restablecimiento de contraseña: ${e.message}');
        SnackBarWidget(
          message:
              'Error al enviar el correo electrónico de restablecimiento de contraseña: ${e.message}',
          backgroundColor: Colors.red,
        ).showSnackBar(context);
      }
    } catch (e) {
      // Otros errores que no son de Firebase Authentication
      print('Error inesperado: $e');
    }
  }

  Future<Map<String, dynamic>?> getCliente(
      BuildContext context, String email, String pass) async {
    try {
      // Autenticar al usuario por correo electrónico y contraseña
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      // Obtener el usuario autenticado
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Obtener el ID del cliente usando el método proporcionado

        // Obtener el documento del cliente en Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('clientes')
            .doc(user.uid)
            .get();

        // Obtener todos los campos del cliente
        String newContra = userDoc['contra'];
        String email = userDoc['correo'];
        String nombre = userDoc['nombre'];
        String apellido = userDoc['apellido'];
        String telefono = userDoc['telefono'];
        int id = userDoc['id'];

        // Crear un mapa con todos los campos y devolverlo
        return {
          'contra': newContra,
          'correo': email,
          'nombre': nombre,
          'apellido': apellido,
          'telefono': telefono,
          'id': id,
        };
      }
    } catch (e) {
      // Manejo de errores durante el inicio de sesión
      print('Error al iniciar sesión: $e');
    }

    // En caso de error o si el usuario no se encuentra, devolver null
    return null;
  }
}
