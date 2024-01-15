import 'package:flutter/material.dart';
import 'package:snackapp/Screen/Profile/client_services.dart';


class EditProfilePage extends StatefulWidget {
  final String id;
  final String name;
  final String lastname;
  final String phone;
  final String email;

  const EditProfilePage({
    required this.id,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.email,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    lastnameController.text = widget.lastname;
    phoneController.text = widget.phone;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(
                labelText: 'Apellido',
              ),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ClientServices().updateCliente(
                  widget.id,
                  nameController.text,
                  lastnameController.text,
                  phoneController.text,
                  emailController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Guardar cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
