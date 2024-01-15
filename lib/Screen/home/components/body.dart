import 'package:flutter/material.dart';
import 'package:snackapp/Screen/home/components/product_screen.dart';
import 'package:snackapp/Screen/settings/LocalStorage.dart';
import '../../../Services/Api_SnackApp/productService.dart';
import '../constants.dart';
import '../details/details_screen.dart';
import 'featurred_products.dart';
import 'header_with_seachbox.dart';
import 'recomend_products.dart';
import 'title_with_more_bbtn.dart';

class Body2 extends StatelessWidget {
  final String nombre;
  final int id;

  Body2({Key? key, required this.nombre, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Proporciona el alto y ancho total de la pantalla
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Usa HeaderWithSearchBox correctamente
          HeaderWithSearchBox(size: size, nombre: nombre),
          TitleWithMoreBtn(
            title: "Recommended",
            press: () {
              // Navega a la pantalla de detalles (ajusta según tu implementación real)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailsScreen(),
                ),
              );
            },
          ),
          ProductsShow(
            clientName: '',
            idCliente: 1,
          ),
          const SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
