import 'package:flutter/material.dart';
import 'package:shop/models/product.dart'; // Import your product model
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/product_tile.dart';

class WinterSale extends StatefulWidget {
  const WinterSale({Key? key}) : super(key: key);

  @override
  State<WinterSale> createState() => _WinterSaleState();
}

class _WinterSaleState extends State<WinterSale> {
  // Dummy list of products for demonstration
  final List<Product> products = [
    Product(
        name: 'Relaxed Fit OverShirt',
        discount: '\$3599',
        price: 2899,
        description: 'Delivery in 5-10 days',
        imagePath1: 'lib/assets/Products/WinterSale/1/1.jpeg',
        imagePath2: 'lib/assets/Products/WinterSale/1/2.jpeg',
        imagePath3: 'lib/assets/Products/WinterSale/1/3.jpeg',
        imagePath4: 'lib/assets/Products/WinterSale/1/4.jpeg'),
    Product(
        name: 'Slim Fit Easy-iron Shirt',
        discount: '\$1599',
        price: 1199,
        description: 'Delivery in 3-9 days',
        imagePath1: 'lib/assets/Products/WinterSale/2/1.jpeg',
        imagePath2: 'lib/assets/Products/WinterSale/2/2.jpeg',
        imagePath3: 'lib/assets/Products/WinterSale/2/3.jpeg',
        imagePath4: 'lib/assets/Products/WinterSale/2/4.jpeg'),
    Product(
        name: 'Regular Fit Iyocell Shirt',
        discount: '\$1999',
        price: 1399,
        description: 'Delivery in 3-8 days',
        imagePath1: 'lib/assets/Products/WinterSale/3/1.jpeg',
        imagePath2: 'lib/assets/Products/WinterSale/3/2.jpeg',
        imagePath3: 'lib/assets/Products/WinterSale/3/3.jpeg',
        imagePath4: 'lib/assets/Products/WinterSale/3/4.jpeg'),
    Product(
        name: 'Relaxed Flannel Shirt',
        discount: '\$1999',
        price: 1299,
        description: 'Delivery in 2-4 days',
        imagePath1: 'lib/assets/Products/WinterSale/4/1.jpeg',
        imagePath2: 'lib/assets/Products/WinterSale/4/2.jpeg',
        imagePath3: 'lib/assets/Products/WinterSale/4/3.jpeg',
        imagePath4: 'lib/assets/Products/WinterSale/4/4.jpeg'),
    Product(
        name: 'Loose Fit OverShirt',
        discount: '\$2999',
        price: 2249,
        description: 'Delivery in 3-9 days',
        imagePath1: 'lib/assets/Products/WinterSale/5/1.jpeg',
        imagePath2: 'lib/assets/Products/WinterSale/5/2.jpeg',
        imagePath3: 'lib/assets/Products/WinterSale/5/3.jpeg',
        imagePath4: 'lib/assets/Products/WinterSale/5/4.jpeg')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(title: 'WINTER SALE'),
      backgroundColor: Colors.grey.shade100,
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductTile(product: products[index]);
        },
      ),
    );
  }
}
