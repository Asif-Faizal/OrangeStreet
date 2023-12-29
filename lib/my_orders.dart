import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/wishlist_details.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late String userEmail;
  late String userPass;
  late String userName;
  late String name;
  late String number;
  late String house;
  late String town;
  late String pincode;
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
    getAddress();
  }

  void databaseRef() {
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(userName)
        .child('Orders');
  }

  Future<void> getAddress() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        name = prefs.getString('_name') ?? '';
        number = prefs.getString('_number') ?? '';
        house = prefs.getString('_house') ?? '';
        town = prefs.getString('_town') ?? '';
        pincode = prefs.getString('_pincode') ?? '';
      });
    } catch (e) {
      print('Error fetching address: $e');
    }
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('user_name') ?? '';
    print(("$username LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"));
    return username;
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
        title: const Text('Orders'),
      ),
      bottomNavigationBar: Container(
        height: 110,
        color: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order will be Delivered at:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              '$name | $number' ?? 'Loading...',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '$house, $town, $pincode' ?? 'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WishDetailsPage(product: likedItem)));
              },
              child: wishItems(likedItem: likedItem));
        },
        query: dbRef,
      ),
    );
  }

  Widget wishItems({required Map likedItem}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: SizedBox(
        height: 140,
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
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      likedItem['description'],
                      style: const TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          likedItem['discount'],
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$${likedItem['price'].toString()}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
