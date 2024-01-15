import 'dart:ffi';

import 'package:flutter/material.dart';
import 'components/my_bottom_nav_bar.dart';


import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final String clientName;
  final int idCliente;
  final String correo;
  final String apellido;
  final String telefono;

  HomeScreen({Key? key, required this.clientName, required this.idCliente, required this.correo, required this.apellido, required this.telefono})
      : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Body2(
          nombre: clientName,
          id: idCliente,
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(clientName: clientName, idCliente: idCliente, correo: correo, telefono: telefono, apellido: apellido,),
    );
  }
}
