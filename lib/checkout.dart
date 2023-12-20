import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/payment.dart';
import 'package:shop/widgets/addresstextfiels.dart';
import 'package:shop/widgets/appbar.dart';

class Checkout extends StatefulWidget {
  final int totalPrice;
  const Checkout({super.key, required this.totalPrice});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late String userName;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _house = TextEditingController();
  TextEditingController _town = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Checkout'),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddressTextfield(
              hintText: 'Name',
              controller: _name,
            ),
            AddressTextfield(
              hintText: 'Contact Number',
              controller: _number,
            ),
            AddressTextfield(
              hintText: 'House Name / Flat No.',
              controller: _house,
            ),
            AddressTextfield(
              hintText: 'Town / City',
              controller: _town,
            ),
            AddressTextfield(
              hintText: 'Pincode',
              controller: _pincode,
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.deepOrange,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '\$${widget.totalPrice}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(width: 3, color: Colors.white),
                  ),
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      userName = prefs.getString('user_name') ?? '';
                    });
                    _databaseReference
                        .child('Users')
                        .child(userName)
                        .child('Address')
                        .push()
                        .set({
                      'name': _name.text,
                      'number': _number.text,
                      'house': _house.text,
                      'town': _town.text,
                      'pincode': _pincode.text,
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            house: _house.text,
                            town: _town.text,
                            pincode: _pincode.text,
                            totalAmount: widget.totalPrice,
                          ),
                        ));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pay Now!',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(Icons.payment_rounded)
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
