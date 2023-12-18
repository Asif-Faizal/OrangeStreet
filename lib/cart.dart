import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/checkout.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/wishlist.dart';

class CartItem {
  final String name;
  final String description;
  double price;
  final String imageUrl;
  final String size;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.size,
  });

  CartItem.fromJson(Map<dynamic, dynamic> json, this.name, this.description,
      this.price, this.imageUrl, this.size) {
    price = json['price'];
  }
}

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late String userName;
  late DatabaseReference dbRef;

  int totalPrice = 0;
  int itemPrice = 0;
  // DatabaseReference databaseReference = FirebaseDatabase.instance
  //     .ref()
  //     .child("CartItem")
  //     .once()
  //     .then((DataSnapshot snapshot) {
  //       print(snapshot.value);
  //     } as FutureOr Function(DatabaseEvent value)) as DatabaseReference;

/*
dbRef.onValue.listen((event) {
    for(element in event.snapshot.children){
      CartItem item=
    }
  })*/
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    print('$itemPrice');
    print('$totalPrice dddddddddddddddddddddddd');
    setState(() {
      totalPrice += itemPrice;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
      prefs.setString('total_price', totalPrice as String);
    });
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(userName)
        .child('CartItem');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.deepOrange,
        elevation: 0,
        title: const Text('Shopping Cart'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
            child: const Icon(Icons.favorite),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: Container(
        height: 110,
        color: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$totalPrice',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 3,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(width: 3, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Checkout()),
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.shopping_cart),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: FirebaseAnimatedList(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map cartitem = snapshot.value as Map;
          cartitem['key'] = snapshot.key;
          return listItem(cartitem: cartitem);
        },
        query: dbRef,
      ),
    );
  }

  Widget listItem({required Map cartitem}) {
    itemPrice = cartitem['price'];
    print('$itemPrice');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            child: Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(cartitem['imagePath1']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, left: 10, right: 10, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          cartitem['name'],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(cartitem['description']),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          cartitem['discount'],
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16),
                        ),
                        Row(
                          children: [
                            const Text(
                              '\$',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                            Text(
                              cartitem['price'].toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Removed ${cartitem['name']}')));
                //Remove CartItem from realtime Database
                DatabaseReference itemRef = FirebaseDatabase.instance
                    .ref()
                    .child('Users')
                    .child(userName)
                    .child('CartItem/${cartitem['key']}');
                itemRef.remove();
              },
              child: const Icon(
                Icons.delete,
                weight: 20,
                size: 18,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
