import 'package:flutter/material.dart';
import 'package:snackapp/Screen/home/components/featurred_products.dart';
import 'package:snackapp/Screen/home/components/recomend_products.dart';

import '../../../Models/Product.dart';
import '../../../Services/Api_SnackApp/productService.dart';
import '../details/details_screen.dart';
import 'title_with_more_bbtn.dart';

class ProductsShow extends StatefulWidget {
  final String clientName;
  final int idCliente;

  const ProductsShow(
      {Key? key, required this.clientName, required this.idCliente})
      : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductsShow> {
  final AuthproductService productService = AuthproductService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productService.getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Product>? products = snapshot.data;
          if (products != null && products.isNotEmpty) {
            return Column(children: <Widget>[
              RecomendsProducts(products: products.toList()),
              TitleWithMoreBtn(
                title: "Featured Products",
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
              FeaturedProducts(
                products: products.take(3).toList(),
              )
            ]);
          } else {
            return Text('No products available.');
          }
        }
      },
    );
  }
}
