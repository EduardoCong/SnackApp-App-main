// import 'package:flutter/material.dart';
// import 'package:snackapp/Screen/home/constants.dart';
// import 'package:snackapp/Services/Firebase/clienteSingUpFireBase.dart';
// import 'package:snackapp/widgets/showSnackBar.dart';
// import '../../Services/Api_SnackApp/AddClientService.dart';
// import '../../Validation/ValidarPassword.dart';
// import '../../Services/Api_SnackApp/ClientServices.dart';
// import '../../widgets/custom_scaffold.dart';
// import 'signin_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formSignInKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   Widget buildTextField(
//     String label,
//     String hint,
//     TextEditingController controller,
//     String Function(String?)? validator,
//   ) {
//     return TextFormField(
//       validator: validator,
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         hintStyle: const TextStyle(
//           color: Colors.black12,
//         ),
//         border: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Color.fromARGB(235, 1, 2, 1),
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Colors.black12,
//           ),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }

//   Widget buildButton(String text, VoidCallback onPressed) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color.fromARGB(206, 31, 95, 7),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget buildHaveAccountRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           'Already have an account? ',
//           style: TextStyle(
//             color: Colors.black45,
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (e) => SignInScreen(),
//               ),
//             );
//           },
//           child: Text(
//             'Sign In',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.green,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _register() async {
//     if (_formSignInKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Processing Data'),
//           backgroundColor: kPrimaryColor,
//         ),
//       );
//     }

//     Validar validar = Validar();

//     if (passwordController.text.length < 8) {
//       SnackBarWidget(
//               message: 'La contraseña debe tener al menos 8 caracteres.',
//               backgroundColor: Colors.red)
//           .showSnackBar(context);
//       return;
//     }

//     if (!validar.isValidPhoneNumber(phoneController.text.trim())) {
//       SnackBarWidget(
//         backgroundColor: Colors.red,
//         message: 'Por favor, ingresa un número de teléfono válido.',
//       ).showSnackBar(context);
//       return;
//     }

//     if (!validar.isValidEmail(emailController.text.trim())) {
//       SnackBarWidget(
//         backgroundColor: Colors.red,
//         message: 'Por favor, ingresa un correo electrónico válido.',
//       ).showSnackBar(context);
//       return;
//     }

//     AuthClientService authService = AuthClientService();
//     bool isEmailUnique = await authService.isEmailUnique(emailController.text);

//     if (!isEmailUnique) {
//       SnackBarWidget(
//         backgroundColor: Colors.red,
//         message: 'Este correo electrónico ya está registrado.',
//       ).showSnackBar(context);
//       return;
//     }

//     String nombre = nameController.text;
//     String apellido = lastNameController.text;
//     String telefono = phoneController.text.trim();
//     String correo = emailController.text.trim();
//     String contra = passwordController.text;

//     AddClient addClient = AddClient();

//     bool isRegistered = await addClient.registerClient(
//         nombre, apellido, telefono, correo, contra);
//     // signUp.registerFireBase();
//     clienteSignUp signUp = clienteSignUp(
//       emailController: emailController,
//       nameController: nameController,
//       lastNameController: lastNameController,
//       phoneController: phoneController,
//       passwordController: passwordController,
//     );
//     signUp.registerFireBase(context);
//     if (isRegistered) {
//       SnackBarWidget(
//         backgroundColor: Colors.green,
//         message: '¡Usuario registrado correctamente!',
//       ).showSnackBar(context);
//       Future.delayed(
//         const Duration(seconds: 3),
//         () {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => SignInScreen()),
//           );
//         },
//       );
//       SnackBarWidget(
//         backgroundColor: Colors.green,
//         message: '¡Verifica tu cuenta!',
//       ).showSnackBar(context);
//     } else {
//       SnackBarWidget(
//         backgroundColor: Colors.red,
//         message:
//             'Hubo un error al registrar la cuenta. Por favor, inténtelo de nuevo.',
//       ).showSnackBar(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: Column(
//         children: [
//           const Expanded(
//             flex: 1,
//             child: SizedBox(height: 100),
//           ),
//           Expanded(
//             flex: 7,
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40.0),
//                   topRight: Radius.circular(40.0),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formSignInKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       buildWelcomeText(),
//                       const SizedBox(height: 10.0),
//                       buildTextField('Name', 'Enter Name', nameController,
//                           (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Name';
//                         }
//                         return '';
//                       }),
//                       const SizedBox(height: 25.0),
//                       buildTextField(
//                           'LastName', 'Enter LastName', lastNameController,
//                           (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter LastName';
//                         }
//                         return '';
//                       }),
//                       const SizedBox(height: 25.0),
//                       buildTextField('Email', 'Enter Email', emailController,
//                           (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Email';
//                         }
//                         return '';
//                       }),
//                       const SizedBox(height: 25.0),
//                       buildTextField(
//                           'Password', 'Enter Password', passwordController,
//                           (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Password';
//                         }
//                         return '';
//                       }),
//                       const SizedBox(height: 25.0),
//                       buildTextField('Phone', 'Enter Phone', phoneController,
//                           (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Phone';
//                         }
//                         return '';
//                       }),
//                       const SizedBox(height: 25.0),
//                       buildButton('Sign In', _register),
//                       const SizedBox(height: 25.0),
//                       buildHaveAccountRow(),
//                       const SizedBox(height: 20.0),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildWelcomeText() {
//     return Text(
//       'Get Started',
//       style: TextStyle(
//         fontSize: 30.0,
//         fontWeight: FontWeight.w900,
//         color: Color.fromARGB(206, 31, 95, 7),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:snackapp/Screen/home/constants.dart';
import 'package:snackapp/Services/Firebase/clienteSingUpFireBase.dart';
import 'package:snackapp/widgets/showSnackBar.dart';
import '../../Services/Api_SnackApp/AddClientService.dart';
import '../../Validation/ValidarPassword.dart';
import '../../Services/Api_SnackApp/ClientServices.dart';
import '../../widgets/custom_scaffold.dart';
import 'signin_screen.dart';
import 'package:snackapp/widgets/modal_custom.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Widget buildTextField(
    String label,
    String hint,
    TextEditingController controller,
    String Function(String?)? validator,
  ) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.black12,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(235, 1, 2, 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildButton(String text, Future<void> Function() onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });

          await onPressed();

          setState(() {
            isLoading = false;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(206, 31, 95, 7),
        ),
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
      ),
    );
  }

  Widget buildHaveAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (e) => SignInScreen(),
              ),
            );
          },
          child: Text(
            'Sign In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _register() async {
    if (_formSignInKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
          backgroundColor: kPrimaryColor,
        ),
      );
    }

    Validar validar = Validar();

    if (passwordController.text.length < 8) {
      SnackBarWidget(
              message: 'La contraseña debe tener al menos 8 caracteres.',
              backgroundColor: Colors.red)
          .showSnackBar(context);
      return;
    }

    if (!validar.isValidPhoneNumber(phoneController.text.trim())) {
      SnackBarWidget(
        backgroundColor: Colors.red,
        message: 'Por favor, ingresa un número de teléfono válido.',
      ).showSnackBar(context);
      return;
    }

    if (!validar.isValidEmail(emailController.text.trim())) {
      SnackBarWidget(
        backgroundColor: Colors.red,
        message: 'Por favor, ingresa un correo electrónico válido.',
      ).showSnackBar(context);
      return;
    }

    AuthClientService authService = AuthClientService();
    bool isEmailUnique = await authService.isEmailUnique(emailController.text);

    if (!isEmailUnique) {
      SnackBarWidget(
        backgroundColor: Colors.red,
        message: 'Este correo electrónico ya está registrado.',
      ).showSnackBar(context);
      return;
    }

    String nombre = nameController.text;
    String apellido = lastNameController.text;
    String telefono = phoneController.text.trim();
    String correo = emailController.text.trim();
    String contra = passwordController.text;

    AddClient addClient = AddClient();

    bool isRegistered = await addClient.registerClient(
        nombre, apellido, telefono, correo, contra);
    // signUp.registerFireBase();
    clienteSignUp signUp = clienteSignUp(
      emailController: emailController,
      nameController: nameController,
      lastNameController: lastNameController,
      phoneController: phoneController,
      passwordController: passwordController,
    );
    signUp.registerFireBase(context);
    if (isRegistered) {
      SnackBarWidget(
        backgroundColor: Colors.green,
        message: '¡Usuario registrado correctamente!',
      ).showSnackBar(context);
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
      );
      ShowModal(
        backgroundColor: Colors.green,
        message: '¡Verifica tu cuenta!',
      ).showCustomModal(context);
    } else {
      ShowModal(
        backgroundColor: Colors.red,
        message:
            'Hubo un error al registrar la cuenta. Por favor, inténtelo de nuevo.',
      ).showCustomModal(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(height: 100),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildWelcomeText(),
                      const SizedBox(height: 10.0),
                      buildTextField('Name', 'Enter Name', nameController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Name';
                        }
                        return '';
                      }),
                      const SizedBox(height: 25.0),
                      buildTextField(
                          'LastName', 'Enter LastName', lastNameController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter LastName';
                        }
                        return '';
                      }),
                      const SizedBox(height: 25.0),
                      buildTextField('Email', 'Enter Email', emailController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return '';
                      }),
                      const SizedBox(height: 25.0),
                      buildTextField(
                          'Password', 'Enter Password', passwordController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return '';
                      }),
                      const SizedBox(height: 25.0),
                      buildTextField('Phone', 'Enter Phone', phoneController,
                          (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Phone';
                        }
                        return '';
                      }),
                      const SizedBox(height: 25.0),
                      buildButton('Sign In', _register),
                      const SizedBox(height: 25.0),
                      buildHaveAccountRow(),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeText() {
    return Text(
      'Get Started',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w900,
        color: Color.fromARGB(206, 31, 95, 7),
      ),
    );
  }
}
