import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/detailspage.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/button.dart';

class ProductTile extends StatefulWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  late String userEmail;
  late String userPass;
  late String userName;
  late Query dbRef;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
      userEmail = prefs.getString('user_email') ?? '';
      userPass = prefs.getString('user_pass') ?? '';
      dbRef = FirebaseDatabase.instance
          .ref()
          .child('Users')
          .child(userName)
          .child('CartItem');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(product: widget.product)));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: Stack(
            children: [
              Card(
                color: Colors.white,
                elevation: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.product.imagePath1,
                        height: 300,
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.product.discount}',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.deepOrange,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Button(
                          onPressed: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.green,
                                content: Text(
                                    '${widget.product.name} added to Cart')));
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
                                .child("CartItem")
                                .push()
                                .set(model.toJson());
                          },
                          child: Text('Add to Cart'))
                    ],
                  ),
                ),
              ),
              Positioned(
                child: LikeButton(
                  size: 30,
                  bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.grey.shade100,
                      dotSecondaryColor: Colors.deepOrange,
                      dotThirdColor: Colors.blue,
                      dotLastColor: Colors.green),
                  circleColor: CircleColor(
                      start: Colors.grey.shade100, end: Colors.deepOrange),
                ),
                right: 20,
                top: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
