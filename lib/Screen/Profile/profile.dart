import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:snackapp/Screen/Profile/edit_profile.dart';

class ClientServices {
  static const String collectionName = 'clientes';

  Future<DocumentSnapshot> getClienteById(String id) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .get();
  }

  Future<void> updateCliente(String id, String name, String lastname, String phone) async {
    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .update({
      'nombre': name,
      'apellido': lastname,
      'telefono': phone,
      
    });
  }
}

class ProfilePage extends StatefulWidget {
  final String id;
  final String clientName;
  final int idCliente;
  final String correo;
  final String telefono;
  final String apellido;

  const ProfilePage({
    Key? key,
    required this.id,
    required this.clientName,
    required this.idCliente,
    required this.correo,
    required this.telefono,
    required this.apellido
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ClientServices clientService;
  DocumentSnapshot? cliente;

  @override
  void initState() {
    super.initState();
    clientService = ClientServices();
    _loadClienteData();
  }

  Future<void> _loadClienteData() async {
    try {
      cliente = await clientService.getClienteById(widget.id);
      if (mounted) {
        setState(() {});
      }
      print('Datos del cliente: ${cliente?.data()}');
    } catch (e) {
      print('Error cargando datos del cliente: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: ListView(
        children: [
          if (cliente != null)
            ListTile(
              title: Text('Nombre'),
              subtitle: Text(widget.clientName),
            ),
          if (cliente != null)
            ListTile(
              title: Text('Apellido'),
              subtitle: Text(widget.apellido),
            ),
          if (cliente != null)
            ListTile(
              title: Text('Teléfono'),
              subtitle: Text(widget.telefono),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    id: widget.id,
                    name: widget.clientName,
                    lastname: widget.apellido,
                    phone: widget.telefono,
                    email: widget.correo,
                  ),
                ),
              );
            },
            child: Text('Editar perfil'),
          ),
        ],
      ),
    );
  }
}
