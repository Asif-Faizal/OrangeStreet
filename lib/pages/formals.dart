import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/grid_tile.dart';

class FormalsPage extends StatefulWidget {
  const FormalsPage({super.key});

  @override
  State<FormalsPage> createState() => _FormalsPageState();
}

class _FormalsPageState extends State<FormalsPage> {
  List<Product> formalProduct = [
    Product(
        name: 'Polka Dot Cotton Shirt',
        discount: '\$1199',
        price: 999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/formals/1/1.jpeg',
        imagePath2: 'lib/assets/Products/formals/1/2.jpeg',
        imagePath3: 'lib/assets/Products/formals/1/3.jpeg',
        imagePath4: 'lib/assets/Products/formals/1/4.jpeg'),
    Product(
        name: 'Easy Iron White Shirt',
        discount: '\$1099',
        price: 999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/formals/2/1.jpeg',
        imagePath2: 'lib/assets/Products/formals/2/2.jpeg',
        imagePath3: 'lib/assets/Products/formals/2/3.jpeg',
        imagePath4: 'lib/assets/Products/formals/2/4.jpeg'),
    Product(
        name: 'Plain-knit shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/formals/3/1.webp',
        imagePath2: 'lib/assets/Products/formals/3/2.webp',
        imagePath3: 'lib/assets/Products/formals/3/3.webp',
        imagePath4: 'lib/assets/Products/formals/3/4.webp'),
    Product(
        name: 'SeerSucker Shirt',
        discount: '\$1899',
        price: 1625,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/formals/4/1.webp',
        imagePath2: 'lib/assets/Products/formals/4/2.webp',
        imagePath3: 'lib/assets/Products/formals/4/3.webp',
        imagePath4: 'lib/assets/Products/formals/4/4.webp'),
    Product(
        name: 'RegularFit Silk Shirt',
        discount: '\$1850',
        price: 1799,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/formals/5/1.webp',
        imagePath2: 'lib/assets/Products/formals/5/2.webp',
        imagePath3: 'lib/assets/Products/formals/5/3.webp',
        imagePath4: 'lib/assets/Products/formals/5/4.webp'),
    Product(
        name: 'Stretch fabric Shirt',
        discount: '\$1099',
        price: 1049,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/formals/6/1.webp',
        imagePath2: 'lib/assets/Products/formals/6/2.webp',
        imagePath3: 'lib/assets/Products/formals/6/3.webp',
        imagePath4: 'lib/assets/Products/formals/6/4.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: MyAppBar(title: 'Formals'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 307),
          itemCount: formalProduct.length,
          itemBuilder: (context, index) {
            return GridProductTile(product: formalProduct[index]);
          },
        ),
      ),
    );
  }
}
