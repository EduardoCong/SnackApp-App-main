import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:snackapp/Screen/settings/LocalStorage.dart';

import '../../Login/signin_screen.dart';
import '../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  final String nombre;

  const HeaderWithSearchBox({
    Key? key,
    required this.size,
    required this.nombre,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 4.5),
      height: size.height * 0.32,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 3 + kDefaultPadding,
            ),
            height: size.height * 0.29,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi $nombre!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Image.network(
                  'https://images.vexels.com/media/users/3/128052/isolated/preview/041e8057f477c462d5b4b78952799816-icono-de-circulo-de-dibujos-animados-de-gallina.png',
                  width: 60,
                )
              ],
            ),
          ),
          Container(
              child: Row(
            children: <Widget>[
              const Spacer(),
              IconButton(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding + 10),
                icon: const Icon(Icons.exit_to_app),
                color: Colors.white,
                onPressed: () async {
                  await LocalStorageManager.clearLoggedInUserInfo();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
              )
            ],
          )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/icons/search.svg",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
