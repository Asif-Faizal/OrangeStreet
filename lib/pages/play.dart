import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/grid_tile.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> {
  List<Product> sportsProduct = [
    Product(
        name: 'Loose Fit Sports top',
        discount: '\$1099',
        price: 999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/1/1.jpeg',
        imagePath2: 'lib/assets/Products/Sports/1/2.jpeg',
        imagePath3: 'lib/assets/Products/Sports/1/3.jpeg',
        imagePath4: 'lib/assets/Products/Sports/1/4.jpeg'),
    Product(
        name: 'Muscle Fit Sports top',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/2/1.jpeg',
        imagePath2: 'lib/assets/Products/Sports/2/2.jpeg',
        imagePath3: 'lib/assets/Products/Sports/2/3.jpeg',
        imagePath4: 'lib/assets/Products/Sports/2/4.jpeg'),
    Product(
        name: 'DryMove Sports top',
        discount: '\$1249',
        price: 1199,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/3/1.jpeg',
        imagePath2: 'lib/assets/Products/Sports/3/2.jpeg',
        imagePath3: 'lib/assets/Products/Sports/3/3.jpeg',
        imagePath4: 'lib/assets/Products/Sports/3/4.jpeg'),
    Product(
        name: 'PSG Third',
        discount: '\$3099',
        price: 2695,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/4/1.webp',
        imagePath2: 'lib/assets/Products/Sports/4/2.jpeg',
        imagePath3: 'lib/assets/Products/Sports/4/3.webp',
        imagePath4: 'lib/assets/Products/Sports/4/4.jpeg'),
    Product(
        name: 'Chelsea FC Home',
        discount: '\$3099',
        price: 2695,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/5/1.webp',
        imagePath2: 'lib/assets/Products/Sports/5/2.webp',
        imagePath3: 'lib/assets/Products/Sports/5/3.webp',
        imagePath4: 'lib/assets/Products/Sports/5/4.jpeg'),
    Product(
        name: 'Liverpool FC Home',
        discount: '\$3099',
        price: 2695,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/6/1.jpeg',
        imagePath2: 'lib/assets/Products/Sports/6/2.jpeg',
        imagePath3: 'lib/assets/Products/Sports/6/3.jpeg',
        imagePath4: 'lib/assets/Products/Sports/6/4.jpeg'),
    Product(
        name: 'Dri-FIT Rise 365',
        discount: '\$2600',
        price: 2495,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Sports/7/1.jpeg',
        imagePath2: 'lib/assets/Products/Sports/7/2.jpeg',
        imagePath3: 'lib/assets/Products/Sports/7/3.webp',
        imagePath4: 'lib/assets/Products/Sports/7/4.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: MyAppBar(title: 'Sports Wear'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 307),
          itemCount: sportsProduct.length,
          itemBuilder: (context, index) {
            return GridProductTile(product: sportsProduct[index]);
          },
        ),
      ),
    );
  }
}
