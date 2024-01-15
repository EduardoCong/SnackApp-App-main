import 'package:flutter/material.dart';
import '../../../Models/Product.dart';
import '../../../Services/Api_SnackApp/productService.dart';
import 'product_screen.dart';
import '../constants.dart';
import '../details/details_screen.dart';

class RecomendsProducts extends StatelessWidget {
  RecomendsProducts({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < products.length; i++)
            RecomendProductCard(
              image: '${products[i].Imagen}',
              title: products[i].NombreProducto,
              tamano: products[i].Tamano,
              price: products[i].Precio.toInt(),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class RecomendProductCard extends StatelessWidget {
  const RecomendProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.tamano,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, tamano;
  final int price;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.width * 0.6,
      margin: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: size.width * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              height: size.width * 0.2,
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontSize: 13),
                          ),
                          TextSpan(
                            text: "$tamano".toUpperCase(),
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                              fontSize: 10
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: kPrimaryColor,fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
