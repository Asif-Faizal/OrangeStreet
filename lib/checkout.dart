import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/payment.dart';
import 'package:shop/widgets/addresstextfiels.dart';
import 'package:shop/widgets/appbar.dart';

class Checkout extends StatefulWidget {
  final int totalPrice;

  const Checkout({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);

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
        child: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AddressTextfield(
                  hintText: 'Name',
                  controller: _name,
                  validator: validateName,
                ),
                AddressTextfield(
                  hintText: 'Contact Number',
                  controller: _number,
                  validator: validateNumber,
                ),
                AddressTextfield(
                  hintText: 'House Name / Flat No.',
                  controller: _house,
                  validator: validateHouse,
                ),
                AddressTextfield(
                  hintText: 'Town / City',
                  controller: _town,
                  validator: validateTown,
                ),
                AddressTextfield(
                  hintText: 'Pincode',
                  controller: _pincode,
                  validator: validatePincode,
                ),
                SizedBox(
                  height: 30,
                )
              ],
            );
          },
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
                    fontWeight: FontWeight.bold,
                  ),
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

                    String? validationMessage = _validateInputs();
                    if (validationMessage != null) {
                      _showErrorSnackBar(context, validationMessage);
                      return;
                    }

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
                      ),
                    );
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

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty) {
      return 'Please enter your 10-digit contact number';
    } else if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null;
  }

  String? validateHouse(String value) {
    if (value.isEmpty) {
      return 'Please enter your house name or flat number';
    }
    return null;
  }

  String? validateTown(String value) {
    if (value.isEmpty) {
      return 'Please enter your town or city';
    }
    return null;
  }

  String? validatePincode(String value) {
    if (value.isEmpty) {
      return 'Please enter your pincode';
    }
    if (value.length != 6) {
      return 'Please enter a valid 6-digit pincode';
    }
    return null;
  }

  String? _validateInputs() {
    if (validateName(_name.text) != null) {
      return 'Please enter your name';
    }
    if (validateNumber(_number.text) != null) {
      return 'Please enter your contact number';
    }
    if (validateHouse(_house.text) != null) {
      return 'Please enter your house name or flat number';
    }
    if (validateTown(_town.text) != null) {
      return 'Please enter your town or city';
    }
    if (validatePincode(_pincode.text) != null) {
      return 'Please enter your pincode';
    }

    return null;
  }
}
