import 'package:flutter/material.dart';
import 'package:shop/widgets/appbar.dart';
import 'package:shop/widgets/drawer.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: MyAppBar(title: "Orders"),
      drawer: MyDrawer(),
    );
  }
}
