import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/detailspage.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/drawer.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
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
    dbRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(userName)
        .child('WishList');
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
          ],
        ),
      ),
      body: FirebaseAnimatedList(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map orderitem = snapshot.value as Map;
          orderitem['key'] = snapshot.key;
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            product: Product(
                                name: orderitem['name'],
                                discount: orderitem['discount'],
                                price: orderitem['price'],
                                description: orderitem['description'],
                                imagePath1: orderitem['imagePath1'],
                                imagePath2: orderitem['imagePath2'],
                                imagePath3: orderitem['imagePath3'],
                                imagePath4: orderitem['imagePath4']))));
              },
              child: orderItems(orderitem: orderitem));
        },
        query: dbRef,
      ),
    );
  }

  Widget orderItems({required Map orderitem}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: SizedBox(
        height: 150,
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset(orderitem['imagePath1']),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 15, left: 10, right: 10, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      orderitem['name'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      orderitem['description'],
                      style: const TextStyle(fontSize: 15),
                    ),
                    Spacer(),
                    Text(
                      orderitem['discount'],
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough, fontSize: 16),
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
                          orderitem['price'].toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
