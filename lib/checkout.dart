import 'package:flutter/material.dart';
import 'package:shop/payment.dart';
import 'package:shop/widgets/addresstextfiels.dart';
import 'package:shop/widgets/appbar.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _house = TextEditingController();
  TextEditingController _town = TextEditingController();
  TextEditingController _pincode = TextEditingController();
  TextEditingController _state = TextEditingController();

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
            AddressTextfield(
              hintText: 'State',
              controller: _state,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 110,
        color: Colors.deepOrange,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(width: 3, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        house: _house.text,
                        town: _town.text,
                        pincode: _pincode.text,
                      ),
                    ));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pay Now!',
                      style: TextStyle(fontSize: 24),
                    ),
                    Icon(Icons.payment_rounded)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
