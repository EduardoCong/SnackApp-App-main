import 'package:flutter/material.dart';

import '../../../Models/Product.dart';
import '../constants.dart';

class FeaturedProducts extends StatelessWidget {
  FeaturedProducts({
    Key? key, required this.products,
  }) : super(key: key);
    final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            FeatureProductCard(
              image:products[i].Imagen,
              nombre: products[i].NombreProducto,
              press: () {},
            ),
        ],
      ),
    );
  }
}

class FeatureProductCard extends StatelessWidget {
  FeatureProductCard({
    Key? key,
    required this.image,
    required this.nombre,
    required this.press,
  }) : super(key: key);
  final String image;
  final String nombre;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press(),
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.3,
        height: size.height*0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
