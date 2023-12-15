import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/cart.dart';
import 'package:shop/widgets/drawer.dart';

class Wishlist extends StatefulWidget {
  final DatabaseReference initdbRef;
  const Wishlist({Key? key, required this.initdbRef}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late String userEmail;
  late String userPass;
  late String userName;
  late Query dbRef;
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  void initializeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
    });
    databaseRef();
  }

  void databaseRef() {
    dbRef = widget.initdbRef.child('Users').child(userName).child('WishList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.deepOrange,
        elevation: 0,
        title: const Text('WishList'),
      ),
      bottomNavigationBar: Container(
        height: 110,
        color: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(width: 3, color: Colors.white),
              ),
              onPressed: () {
                //   Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => Cart(initdbRef: dbRef,)));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Go to Cart',
                      style: TextStyle(fontSize: 20),
                    ),
                    Icon(Icons.shopping_cart)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: FirebaseAnimatedList(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map likedItem = snapshot.value as Map;
          likedItem['key'] = snapshot.key;
          return wishItems(likedItem: likedItem);
        },
        query: dbRef,
      ),
    );
  }

  Widget wishItems({required Map likedItem}) {
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
                    child: Image.asset(likedItem['imagePath1']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, left: 10, right: 10, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          likedItem['name'],
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(likedItem['description']),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          likedItem['discount'],
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
                              likedItem['price'].toString(),
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
                    content: Text('Removed ${likedItem['name']}')));
                //Remove CartItem from realtime Database
                DatabaseReference itemRef = FirebaseDatabase.instance
                    .ref()
                    .child('Users')
                    .child(userName)
                    .child('WishList/${likedItem['key']}');
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
