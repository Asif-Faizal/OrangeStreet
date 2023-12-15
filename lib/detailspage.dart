import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/button.dart';
import 'package:shop/widgets/drawer.dart';

class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late String userEmail;
  late String userPass;
  late String userName;
  bool _isFilled = false;

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
            Stack(
              children: [
                CarouselSlider(
                  items: [
                    Image.asset(
                      widget.product.imagePath1,
                      scale: 1,
                    ),
                    Image.asset(
                      widget.product.imagePath2,
                      scale: 1,
                    ),
                    Image.asset(
                      widget.product.imagePath3,
                      scale: 1,
                    ),
                    Image.asset(
                      widget.product.imagePath4,
                      scale: 1,
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
                Positioned(
                  right: 15,
                  bottom: 15,
                  child: IconButton(
                    splashRadius: 2,
                    onPressed: () async {
                      setState(() async {
                        if (_isFilled) {
                          final database = FirebaseDatabase.instance.refFromURL(
                              'https://orange-street-default-rtdb.firebaseio.com/');
                          database
                              .child('Users')
                              .child(userName)
                              .child('WishList')
                              . /*child(path)*/ remove();
                          _isFilled = false;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                '${widget.product.name} removed from WishList'),
                          ));
                        } else {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          setState(() {
                            userName = prefs.getString('user_name') ?? '';
                          });
                          final DatabaseReference database =
                              FirebaseDatabase.instance.refFromURL(
                                  'https://orange-street-default-rtdb.firebaseio.com/');
                          final model = Product(
                              name: widget.product.name,
                              discount: widget.product.discount,
                              price: widget.product.price,
                              description: widget.product.description,
                              imagePath1: widget.product.imagePath1,
                              imagePath2: widget.product.imagePath2,
                              imagePath3: widget.product.imagePath3,
                              imagePath4: widget.product.imagePath4);
                          database
                              .child('Users')
                              .child(userName)
                              .child("WishList")
                              .push()
                              .set(model.toJson());
                          _isFilled = true;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            content: Text(
                                '${widget.product.name} added to WishList'),
                          ));
                        }
                        // _isFilled = !_isFilled;
                      });
                    },
                    icon: _isFilled
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${widget.product.name}',
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
                  '${widget.product.description}',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                Spacer()
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '${widget.product.discount}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '\$${widget.product.price}',
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      content: Text('${widget.product.name} added to Cart')));
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  setState(() {
                    userName = prefs.getString('user_name') ?? '';
                    userEmail = prefs.getString('user_email') ?? '';
                    userPass = prefs.getString('user_pass') ?? '';
                  });
                  final DatabaseReference database = FirebaseDatabase.instance
                      .refFromURL(
                          'https://orange-street-default-rtdb.firebaseio.com/');
                  final model = Product(
                      name: widget.product.name,
                      discount: widget.product.discount,
                      price: widget.product.price,
                      description: widget.product.description,
                      imagePath1: widget.product.imagePath1,
                      imagePath2: widget.product.imagePath2,
                      imagePath3: widget.product.imagePath3,
                      imagePath4: widget.product.imagePath4);
                  database
                      .child('Users')
                      .child(userName)
                      .child("CartItem")
                      .push()
                      .set(model.toJson());
                },
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      'Add To Cart  ',
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
