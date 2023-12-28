import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/online_payments.dart';
import 'package:shop/order_placed_animtn.dart';
import 'package:shop/widgets/appbar.dart';

enum PaymentMethod { cod, online, pay_later }

// ignore: must_be_immutable
class PaymentScreen extends StatefulWidget {
  final String house;
  final String town;
  final String pincode;
  int totalAmount;

  PaymentScreen({
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
  PaymentMethod _groupValue = PaymentMethod.cod;
  TextEditingController _coupon = TextEditingController();
  late String userName;
  bool isCouponApplied = false;

  @override
  void initState() {
    super.initState();
  }

  applyCoupon() {
    if (isCouponApplied) {
      // Coupon already applied, show a message or handle as needed
      // For example, you can display a SnackBar with an appropriate message.
      SnackBar snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text("Coupon FLAT30 has already been applied."),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      String couponCode = _coupon.text.trim();
      if (couponCode == "FLAT30") {
        double discountPercentage = 0.30;
        double discountAmount = widget.totalAmount * discountPercentage;
        setState(() {
          widget.totalAmount -= discountAmount.toInt();
          isCouponApplied =
              true; // Set the flag to true after applying the coupon
        });

        // Display the snackbar
        SnackBar snackBar = SnackBar(
          closeIconColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Text("Coupon FLAT30 applied successfully!"),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            textColor: Colors.white,
            label: "UNDO",
            onPressed: () {
              // Implement logic to undo the coupon if needed
              setState(() {
                widget.totalAmount += discountAmount.toInt();
                isCouponApplied =
                    false; // Reset the flag if the coupon is undone
              });
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Handle invalid coupon codes
        SnackBar snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text("Invalid coupon code"),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _placeOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
    });

    if (_groupValue == PaymentMethod.online) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnlinePaymentScreen(
            totalAmount: widget.totalAmount,
          ),
        ),
      );
    } else {
      // Move cart items to orders
      await moveCartItemsToOrders(userName);

      // Navigate to the OrderAnimation page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderAnimation()),
      );
    }
  }

  Future<void> moveCartItemsToOrders(String userName) async {
    DatabaseReference cartRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(userName)
        .child('CartItem');

    DatabaseReference ordersRef = FirebaseDatabase.instance
        .ref()
        .child('Users')
        .child(userName)
        .child('Orders');

    // Read cart items
    // Use onValue instead of once to get a DatabaseEvent
    cartRef.onValue.listen((event) {
      Map<dynamic, dynamic>? cartItems = (event.snapshot.value as Map?)?.cast();

      // Move cart items to orders
      if (cartItems != null) {
        for (var entry in cartItems.entries) {
          ordersRef.push().set(entry.value);
        }
      }

      // Remove cart items after moving to orders
      cartRef.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const MyAppBar(title: 'Payments'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deliver to:  ${widget.house}, ${widget.town}, ${widget.pincode}',
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
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _coupon,
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(color: Colors.deepOrange),
                    prefixIcon:
                        Icon(Icons.money_off_csred, color: Colors.deepOrange),
                    hintText: 'Coupon Code',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: applyCoupon,
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  '  Payment Options',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(
                              'Cash on Delivery',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            leading: Radio(
                                activeColor: Colors.deepOrange,
                                splashRadius: 10,
                                value: PaymentMethod.cod,
                                groupValue: _groupValue,
                                onChanged: (PaymentMethod? value) {
                                  setState(() {
                                    _groupValue = value!;
                                  });
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text('Pay Online',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            leading: Radio(
                                activeColor: Colors.deepOrange,
                                splashRadius: 10,
                                value: PaymentMethod.online,
                                groupValue: _groupValue,
                                onChanged: (PaymentMethod? value) {
                                  setState(() {
                                    _groupValue = value!;
                                  });
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text('Pay Later',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            leading: Radio(
                                activeColor: Colors.deepOrange,
                                splashRadius: 10,
                                value: PaymentMethod.pay_later,
                                groupValue: _groupValue,
                                onChanged: (PaymentMethod? value) {
                                  setState(() {
                                    _groupValue = value!;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
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
                  // onPressed: () async {
                  //   SharedPreferences prefs =
                  //       await SharedPreferences.getInstance();
                  //   setState(() {
                  //     userName = prefs.getString('user_name') ?? '';
                  //   });
                  //   final DatabaseReference database = FirebaseDatabase.instance
                  //       .refFromURL(
                  //           'https://orange-street-default-rtdb.firebaseio.com/');
                  //   // final model = Product(
                  //   //   name: widget.cartItems[i]['name'],
                  //   //   discount: widget.cartItems[i]['discount'],
                  //   //   price: widget.cartItems[i]['price'],
                  //   //   description: widget.cartItems[i]['description'],
                  //   //   imagePath1: widget.cartItems[i]['imagePath1'],
                  //   //   imagePath2: widget.cartItems[i]['imagePath2'],
                  //   //   imagePath3: widget.cartItems[i]['imagePath3'],
                  //   //   imagePath4: widget.cartItems[i]['imagePath4'],
                  //   // );
                  //   // database
                  //   //     .child('Users')
                  //   //     .child(userName)
                  //   //     .child("Orders")
                  //   //     .push()
                  //   //     .set(model.toJson());

                  //   const Duration(milliseconds: 200);
                  //   DatabaseReference itemRef = FirebaseDatabase.instance
                  //       .ref()
                  //       .child('Users')
                  //       .child(userName)
                  //       .child('CartItem');
                  //   itemRef.remove();
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const OrderAnimation()));
                  // },
                  onPressed: () {
                    _placeOrder();
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
