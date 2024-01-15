import 'package:flutter/material.dart';
import 'package:snackapp/Screen/Login/welcome_snackapp_view.dart';
import 'package:snackapp/Screen/settings/LocalStorage.dart';
import 'package:snackapp/Services/Api_SnackApp/deleteClient.dart';

import '../../Services/Firebase/clienteDeleteFirebase.dart';

class ProfileScreen extends StatelessWidget {
  final int idCliente;
  final String nombre;
  final String apellido;
  final String telefono;
  final String correoElectronico;
  final String contrasena;

  ProfileScreen({
    required this.nombre,
    required this.apellido,
    required this.telefono,
    required this.correoElectronico,
    required this.contrasena,
    required this.idCliente, required String clientName, required String id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'https://static-00.iconduck.com/assets.00/profile-circle-icon-2048x2048-cqe5466q.png'),
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nombre,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    apellido,
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    CustomListTile(
                      title: 'Teléfono',
                      icon: Icons.phone,
                      subtitle: telefono,
                      onTap: () => _editPhone(context),
                    ),
                    CustomListTile(
                      title: 'Contraseña',
                      icon: Icons.lock,
                      subtitle: contrasena,
                      onTap: () => _editPassword(context),
                    ),
                    CustomListTile(
                      title: 'Correo Electrónico',
                      icon: Icons.email,
                      subtitle: correoElectronico,
                      onTap: () => _editEmail(context),
                    ),
                    CustomListTile(
                      title: 'Eliminar Cuenta',
                      icon: Icons.delete,
                      subtitle: '',
                      onTap: () => _showDeleteAccountModal(context),
                    ),
                    // CustomListTile(
                    //   title: 'Salir de la Cuenta',
                    //   icon: Icons.exit_to_app,
                    //   subtitle: '',
                    //   onTap: () => _logout(context),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editPhone(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPhoneOptionScreen()),
    );
  }

  void _editPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPasswordOptionScreen()),
    );
  }

  void _editEmail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditEmailOptionScreen()),
    );
  }

  void _showDeleteAccountModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DeleteAccountOptionScreen(
          userId: idCliente,
        );
      },
    );
  }

  void _logout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LogoutAccountOptionScreen();
      },
    );
  }
}

class CustomListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final VoidCallback onTap;

  CustomListTile({
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.onTap,
  });

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 18),
      ),
      leading: Icon(widget.icon),
      subtitle: widget.title == 'Contraseña'
          ? GestureDetector(
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              child: Text(
                showPassword ? widget.subtitle : '*' * widget.subtitle.length,
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            )
          : Text(widget.subtitle),
      onTap: widget.onTap,
    );
  }
}

class EditPhoneOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Teléfono'),
      ),
      body: Center(
        child: Text('Pantalla para editar el teléfono'),
      ),
    );
  }
}

class EditPasswordOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Contraseña'),
      ),
      body: Center(
        child: Text('Pantalla para cambiar la contraseña'),
      ),
    );
  }
}

class EditEmailOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Correo Electrónico'),
      ),
      body: Center(
        child: Text('Pantalla para editar el correo electrónico'),
      ),
    );
  }
}

// class DeleteAccountOptionScreen extends StatelessWidget {
//   final int userId; // Asegúrate de pasar el identificador de usuario

//   DeleteAccountOptionScreen({required this.userId});
//   deleteClient delete = deleteClient();
//   Future<void> _eliminarCuenta(BuildContext context) async {
//     // Llamada a la API para eliminar la cuenta
//     await delete.DeleteClient(userId);

//     // Navegar a WelcomeScreen después de eliminar la cuenta
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => WelcomeScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Eliminar Cuenta',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Text('¿Seguro deseas eliminar esta cuenta?'),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               _eliminarCuenta(context);
//             },
//             child: Text('Eliminar Cuenta'),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DeleteAccountOptionScreen extends StatelessWidget {
  final int userId; // Asegúrate de pasar el identificador de usuario

  DeleteAccountOptionScreen({required this.userId});
  DeleteCliente deleteCliente = DeleteCliente();
  deleteClient elimar = deleteClient();
  Future<void> _eliminarCuenta(BuildContext context) async {
    // Llamada a la API para eliminar la cuenta
    await deleteCliente.deleteAccount(context);
    await elimar.DeleteClient(userId);
    await LocalStorageManager.clearLoggedInUserInfo();

    // Navegar a WelcomeScreen después de eliminar la cuenta
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Eliminar Cuenta',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('¿Seguro deseas eliminar esta cuenta?'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _eliminarCuenta(context);
            },
            child: Text('Eliminar Cuenta'),
          ),
        ],
      ),
    );
  }
}

class LogoutAccountOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Salir de la Cuenta',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('¿Seguro deseas salir de esta cuenta?'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              ); // Cierra el modal
            },
            child: Text('Salir'),
          ),
        ],
      ),
    );
  }
}
