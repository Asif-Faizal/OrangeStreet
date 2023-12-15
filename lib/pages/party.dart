import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/grid_tile.dart';

class PartyPage extends StatefulWidget {
  const PartyPage({super.key});

  @override
  State<PartyPage> createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  List<Product> partyProduct = [
    Product(
        name: 'Long-sleeved resort shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/1/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/1/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/1/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/1/4.jpeg'),
    Product(
        name: 'Fit Short-sleeved shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/2/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/2/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/2/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/2/4.jpeg'),
    Product(
        name: 'Short-sleeved resort shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/3/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/3/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/3/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/3/4.jpeg'),
    Product(
        name: 'Short-sleeved lyocell shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/4/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/4/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/4/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/4/4.jpeg'),
    Product(
        name: 'Short-sleeved Rayon shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/5/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/5/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/5/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/5/4.jpeg'),
    Product(
        name: 'Short-sleeved Satin shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/6/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/6/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/6/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/6/4.jpeg'),
    Product(
        name: 'Regular Fit Viscose shirt',
        discount: '\$2099',
        price: 1999,
        description: 'Delivery in 3 - 6 days',
        imagePath1: 'lib/assets/Products/Party/7/1.jpeg',
        imagePath2: 'lib/assets/Products/Party/7/2.jpeg',
        imagePath3: 'lib/assets/Products/Party/7/3.jpeg',
        imagePath4: 'lib/assets/Products/Party/7/4.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: MyAppBar(title: 'Party Wear'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 307),
          itemCount: partyProduct.length,
          itemBuilder: (context, index) {
            return GridProductTile(product: partyProduct[index]);
          },
        ),
      ),
    );
  }
}
