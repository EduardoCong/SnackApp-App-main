import 'package:cloud_firestore/cloud_firestore.dart';

class ClientServices {
  static const String collectionName = 'clientes';

  Future<DocumentSnapshot> getClienteById(String id) async {
    return await FirebaseFirestore.instance
    
        .collection(collectionName)
        .doc(id)
        .get();
  }

  Future<void> updateCliente(
      String id, String name, String lastname, String phone, String email) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .update({
      'nombre': name,
      'apellido': lastname,
      'telefono': phone,
      'correo': email,
    });
  }
}
