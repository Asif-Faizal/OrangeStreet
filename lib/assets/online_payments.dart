import 'package:flutter/material.dart';
import 'package:shop/widgets/appbar.dart';

class OnlinePaymentScreen extends StatelessWidget {
  const OnlinePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Pay Online'),
    );
  }
}
