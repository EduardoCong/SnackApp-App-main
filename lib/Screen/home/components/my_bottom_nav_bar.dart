import 'package:flutter/material.dart';
import 'package:snackapp/Screen/Profile/profile.dart';
import 'package:snackapp/Screen/home/home_screen.dart';
import 'package:snackapp/Screen/home/components/product_screen.dart';
import '../constants.dart';

class MyBottomNavBar extends StatelessWidget {
  final String clientName;
  final int idCliente;
  final String correo;
  final String telefono;
  final String apellido;

  const MyBottomNavBar({
    Key? key,
    required this.clientName,
    required this.idCliente,
    required this.correo,
    required this.telefono,
    required this.apellido
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) async {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    clientName: clientName,
                    idCliente: idCliente, correo: correo, apellido: apellido, telefono: telefono,
                  ),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsShow(
                    clientName: clientName,
                    idCliente: idCliente,
                  ),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsShow(
                    clientName: '',
                    idCliente: 1,
                  ),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    id: idCliente.toString(),
                    clientName: clientName,
                    idCliente: idCliente,
                    apellido: apellido,
                    telefono: telefono,
                    correo: correo,
                  ),
                ),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify_sharp),
            label: 'Tienda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cuenta',
          ),
        ],
      ),
    );
  }
}
