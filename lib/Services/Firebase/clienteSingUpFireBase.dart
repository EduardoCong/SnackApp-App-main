import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackapp/widgets/showSnackBar.dart';

import '../Api_SnackApp/ClientServices.dart';

class clienteSignUp {
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  clienteSignUp({
    required this.nameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
  });

  
  Future<void> registerFireBase(BuildContext context) async {
    AuthClientService authService = AuthClientService();
    try {
      String nombre = nameController.text;
      String apellido = lastNameController.text;
      String telefono = phoneController.text.trim();
      String correo = emailController.text.trim();
      String contra = passwordController.text;
      int clientId = await authService.idOfClienteWithEmail(correo);

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correo,
        password: contra,
      );
      await userCredential.user!.sendEmailVerification();

      String userId = userCredential.user!.uid;
      // Agregar información del cliente a la colección 'clientes' en Firestore
      await FirebaseFirestore.instance.collection('clientes').doc(userId).set({
        'contra': contra,
        'correo': correo,
        'id': clientId,
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarWidget(
          message: 'The password provided is too weak.',
          backgroundColor: Colors.red,
        ).showSnackBar(context);
      } else if (e.code == 'email-already-in-use') {
        SnackBarWidget(
          message: 'The account already exists for that email.',
          backgroundColor: Colors.red,
        ).showSnackBar(context);
      }
    } catch (e) {
      SnackBarWidget(
        message: 'Error durante el registro: $e',
        backgroundColor: Colors.red,
      ).showSnackBar(context);
    }
  }
}
