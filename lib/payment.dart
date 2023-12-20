import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/models/product.dart';
import 'package:shop/order_placed_animtn.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/textfield.dart';

class PaymentScreen extends StatefulWidget {
  final String house;
  final String town;
  final String pincode;
  final int totalAmount;

  const PaymentScreen({
    Key? key,
    required this.house,
    required this.town,
    required this.pincode,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String userName;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const MyAppBar(title: 'Payments'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Deliver to: ${widget.house} ${widget.town} ${widget.pincode}',
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'CHANGE',
                          style: TextStyle(color: Colors.deepOrange),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const CustomTextField(
                prefixIcon: Icons.money_off_rounded,
                hintText: 'Enter Coupon Code'),
            const SizedBox(
              width: double.infinity,
              child: Text(
                '  Payment Options',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Cash On Delivery',
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          Icons.money_rounded,
                          size: 45,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Pay Online',
                          style:
                              TextStyle(color: Colors.deepOrange, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          Icons.payment_rounded,
                          size: 45,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.deepOrange,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.totalAmount}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(width: 3, color: Colors.white),
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      userName = prefs.getString('user_name') ?? '';
                    });
                    final DatabaseReference database = FirebaseDatabase.instance
                        .refFromURL(
                            'https://orange-street-default-rtdb.firebaseio.com/');
                    final model = Product(
                        name: cartitem['name'],
                        discount: cartitem['discount'],
                        price: cartitem['price'],
                        description: cartitem['description'],
                        imagePath1: cartitem['imagePath1'],
                        imagePath2: cartitem['imagePath2'],
                        imagePath3: cartitem['imagePath3'],
                        imagePath4: cartitem['imagePath4']);
                    database
                        .child('Users')
                        .child(userName)
                        .child("Orders")
                        .push()
                        .set(model.toJson());
                    DatabaseReference itemRef = FirebaseDatabase.instance
                        .ref()
                        .child('Users')
                        .child(userName)
                        .child('CartItem/${cartitem['key']}');
                    itemRef.remove();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderAnimation()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Place Order',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.done_outline_rounded)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
