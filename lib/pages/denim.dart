import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/grid_tile.dart';

class DenimPage extends StatefulWidget {
  const DenimPage({super.key});

  @override
  State<DenimPage> createState() => _DenimPageState();
}

class _DenimPageState extends State<DenimPage> {
  final List<Product> denimproduct = [
    Product(
        name: 'Blue Fit Denim Shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Denim/1/1.jpeg',
        imagePath2: 'lib/assets/Products/Denim/1/2.jpeg',
        imagePath3: 'lib/assets/Products/Denim/1/3.jpeg',
        imagePath4: 'lib/assets/Products/Denim/1/4.jpeg'),
    Product(
        name: 'Indigo Fit Denim Shirt',
        discount: '\$2199',
        price: 2099,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Denim/2/1.jpeg',
        imagePath2: 'lib/assets/Products/Denim/2/2.jpeg',
        imagePath3: 'lib/assets/Products/Denim/2/3.jpeg',
        imagePath4: 'lib/assets/Products/Denim/2/4.jpeg'),
    Product(
        name: 'Flannel Demin Overshirt',
        discount: '\$2399',
        price: 2349,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Denim/3/1.jpeg',
        imagePath2: 'lib/assets/Products/Denim/3/2.jpeg',
        imagePath3: 'lib/assets/Products/Denim/3/3.jpeg',
        imagePath4: 'lib/assets/Products/Denim/3/4.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: MyAppBar(title: 'CHOOSE DENIM'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 307),
          itemCount: denimproduct.length,
          itemBuilder: (context, index) {
            return GridProductTile(product: denimproduct[index]);
          },
        ),
      ),
    );
  }
}
