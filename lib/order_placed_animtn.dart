import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop/homepage.dart';

class OrderAnimation extends StatefulWidget {
  const OrderAnimation({super.key});

  @override
  State<OrderAnimation> createState() => _OrderAnimationState();
}

class _OrderAnimationState extends State<OrderAnimation> {
  @override
  void initState() {
    super.initState();
    _orderAnimate();
  }

  void _orderAnimate() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Lottie.network(
                "https://lottie.host/9f0cd495-8769-4aa8-ba70-e69ce98deb2d/fCDRLlDoxO.json",
                repeat: false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "order placed".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
