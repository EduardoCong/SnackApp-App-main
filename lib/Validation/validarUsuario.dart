import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> obtenerCliente(String email) async {
  try {
    // Obtener el usuario por correo electrónico
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: 'dummy_password', // Contraseña ficticia, solo para verificar la existencia del usuario
    );

    // Obtener la referencia al documento del cliente en Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('clientes').doc(userCredential.user!.uid).get();

    // Obtener los datos del cliente
    Object? userData = userDoc.data();

    // Imprimir o utilizar los datos según sea necesario
    print('Datos del cliente: $userData');

    // Devolver el usuario autenticado
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    // Manejar excepciones específicas de FirebaseAuth
    if (e.code == 'user-not-found') {
      print('No se encontró un usuario con el correo electrónico proporcionado.');
    } else if (e.code == 'wrong-password') {
      print('Contraseña incorrecta.');
    }
  } catch (e) {
    // Manejar otros errores
    print(e);
  }

  // En caso de error o si el usuario no se encuentra, devolver null
  return null;
}
