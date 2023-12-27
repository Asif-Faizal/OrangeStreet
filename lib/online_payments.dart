import 'package:flutter/material.dart';
import 'package:shop/widgets/appbar.dart';

class OnlinePaymentScreen extends StatelessWidget {
  final int totalAmount;
  const OnlinePaymentScreen({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(title: 'Pay Online'),
    );
  }
}
