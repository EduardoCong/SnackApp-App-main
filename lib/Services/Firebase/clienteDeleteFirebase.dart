import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackapp/widgets/showSnackBar.dart';

class DeleteCliente {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
      SnackBarWidget(
        backgroundColor: Colors.green,
        message: 'Cuenta eliminada exitosamente.',
      ).showSnackBar(context);
    } on FirebaseAuthException catch (e) {
      SnackBarWidget(
        backgroundColor: Colors.red,
        message: e.message!,
      ).showSnackBar(context);
    }
  }
}
