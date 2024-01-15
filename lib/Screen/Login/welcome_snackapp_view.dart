// In your WelcomeScreen widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snackapp/Validation/validarUsuario.dart';
import '../../widgets/custom_scaffold.dart';
import '../home/home_screen.dart';
import '../settings/LocalStorage.dart';
import 'signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 40.0,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome    to SnackApp!\n',
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text:
                              '\nOrder the best meals in Mérida and have them delivered to your doorstep or in the park in little or no time. Doesn’t that sound delicious???',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200.0,
                child: WelcomeButton(
                  onTap: () {},
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const WelcomeButton({
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Map<String, dynamic> isLoggedIn =
            await LocalStorageManager.getLoggedInUserInfo();
        print(isLoggedIn);
        if (isLoggedIn['clientName'] == null && isLoggedIn['id'] == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignInScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                clientName: isLoggedIn['clientName'],
                idCliente: isLoggedIn['id'],
              ),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      child: Icon(Icons.arrow_forward),
    );
  }
  }
