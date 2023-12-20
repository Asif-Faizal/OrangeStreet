import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/button.dart';
import 'package:shop/widgets/drawer.dart';

class WishDetailsPage extends StatefulWidget {
  final Map<dynamic, dynamic> product;

  const WishDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<WishDetailsPage> createState() => _WishDetailsPageState();
}

class _WishDetailsPageState extends State<WishDetailsPage> {
  late String userEmail;
  late String userPass;
  late String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: ''),
      drawer: MyDrawer(),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  widget.product['imagePath1'],
                  scale: 1.5,
                ),
                Image.asset(
                  widget.product['imagePath2'],
                  scale: 1.5,
                ),
                Image.asset(
                  widget.product['imagePath3'],
                  scale: 1.5,
                ),
                Image.asset(
                  widget.product['imagePath4'],
                  scale: 1.5,
                ),
              ],
              options: CarouselOptions(
                height: 450,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.easeIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 3000),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${widget.product['name']}',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  '${widget.product['description']}',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Spacer()
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '${widget.product['discount']}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '\$${widget.product['price']}',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            Button(
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    userName = prefs.getString('user_name') ?? '';
                  });
                  final DatabaseReference database = FirebaseDatabase.instance
                      .refFromURL(
                          'https://orange-street-default-rtdb.firebaseio.com/');
                  final model = Product(
                      name: widget.product['name'],
                      discount: widget.product['discount'],
                      price: widget.product['price'],
                      description: widget.product['description'],
                      imagePath1: widget.product['imagePath1'],
                      imagePath2: widget.product['imagePath2'],
                      imagePath3: widget.product['imagePath3'],
                      imagePath4: widget.product['imagePath4']);
                  database
                      .child('Users')
                      .child(userName)
                      .child("CartItem")
                      .push()
                      .set(model.toJson());
                  DatabaseReference itemRef = FirebaseDatabase.instance
                      .ref()
                      .child('Users')
                      .child(userName)
                      .child('WishList/${widget.product['key']}');
                  itemRef.remove();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    content: Text('${widget.product['name']} moved to Cart'),
                  ));
                },
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      'Move To Cart  ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.deepOrange,
                    ),
                    Spacer()
                  ],
                )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
