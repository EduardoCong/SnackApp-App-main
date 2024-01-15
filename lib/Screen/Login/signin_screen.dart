import 'package:flutter/material.dart';
import 'package:snackapp/Screen/Login/signup_screen.dart';
import 'package:snackapp/Screen/home/constants.dart';
import 'package:snackapp/Services/Firebase/clienteSignInFirebase.dart';
import 'package:snackapp/widgets/showDialog_Widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/custom_scaffold.dart';
import '../home/home_screen.dart';
import '../settings/LocalStorage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberPassword = true;
  bool obscureText = true;

  clienteSignIn signIn = clienteSignIn();
  // Liberar controladores de texto en dispose
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget buildWelcomeText() {
    return Text(
      'Welcome back',
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.w900,
        color: Color(0xCE1F5F07),
      ),
    );
  }

  Widget buildEmailTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Email';
        }
        return null;
      },
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter Email',
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

  Widget buildPasswordTextField() {
    return TextFormField(
      obscureText: obscureText,
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Password';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter Password',
        hintStyle: const TextStyle(
          color: Color(0x5CF526),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x5CF526),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.black87,
          ),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
      ),
    );
  }

  Widget buildRememberPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberPassword,
              onChanged: (bool? value) {
                setState(() {
                  rememberPassword = value!;
                });
              },
              activeColor: Colors.green,
            ),
            const Text(
              'Remember me',
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
          ],
        ),
        GestureDetector(
          child: Text(
            'Forget password?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          onTap: () {
            signIn.resetPassword(emailController.text.trim(), context);
          },
        ),
      ],
    );
  }

  Widget buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String email = emailController.text.trim();
          String password = passwordController.text;
          Map<String, dynamic>? cliente =
              await signIn.getCliente(context, email, password);

          if (cliente != null) {
            bool? verificado = await signIn.login(email, password, context);
            print('vammosssssssss aque d ${verificado}');

            if (verificado != null && verificado != false) {
              if (_formSignInKey.currentState!.validate() && rememberPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Process data',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: kPrimaryColor,
                  ),
                );
              } else if (!rememberPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please agree to the processing of personal data',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.white,
                  ),
                );
              }

              if (rememberPassword) {
                String? clientName = cliente['nombre'];
                int? clientId = cliente['id'];

                if (clientName != null && clientId != null) {
                  await LocalStorageManager.saveLoggedInUserInfo(
                      clientName, clientId);
                }
              }

              Map<String, dynamic> isLoggedIn =
                  await LocalStorageManager.getLoggedInUserInfo();
              print(isLoggedIn);
              print('remember ${rememberPassword}');
              var status = await Permission.location.request();

              if (!status.isGranted) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: 'Location Permissions Denied',
                      body: 'Please grant location permissions to continue.',
                      buttonText: 'OK',
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
                return;
              }

              var isLocationEnabled =
                  await Geolocator.isLocationServiceEnabled();
              print("Location is enabled: ${isLocationEnabled}");

              if (isLocationEnabled) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      clientName: cliente['nombre'],
                      idCliente: cliente['id'],
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomAlertDialog(
                      title: 'Location not enabled',
                      body: 'Please enable location to continue.',
                      buttonText: 'Enable Location',
                      onPressed: () async {
                        Navigator.pop(context);
                        await Geolocator.openLocationSettings();
                      },
                    );
                  },
                );
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  title: 'Login Error',
                  body: 'Incorrect credentials. Please try again.',
                  buttonText: 'OK',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xCE1F5F07),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildDontHaveAccountRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (e) => SignUpScreen(),
              ),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: buildSignInContent(),
    );
  }

  Widget buildSignInContent() {
    return Column(
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
                    buildEmailTextField(),
                    const SizedBox(height: 25.0),
                    buildPasswordTextField(),
                    const SizedBox(height: 25.0),
                    buildRememberPasswordRow(),
                    const SizedBox(height: 25.0),
                    buildSignInButton(),
                    const SizedBox(height: 25.0),
                    // buildSinginFacebook(),
                    // const SizedBox(height: 25.0,),
                    // buildSinginGoogle(),
                    // const SizedBox(height: 25.0,),
                    buildDontHaveAccountRow(),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
