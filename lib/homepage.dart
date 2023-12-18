import 'package:flutter/material.dart';
import 'package:shop/cart.dart';
import 'package:shop/homepagelayout.dart';
import 'package:shop/notification.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/wishlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.deepOrange,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'orange street'.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              _buildIconButton(
                onPressed: () => _navigateTo(context, NotificationScreen()),
                icon: Icons.notifications,
              ),
              _buildIconButton(
                onPressed: () => _navigateTo(context, Wishlist()),
                icon: Icons.favorite,
              ),
              _buildIconButton(
                onPressed: () => _navigateTo(context, Cart()),
                icon: Icons.shopping_bag,
              ),
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(child: HomeLayout()),
      drawer: const MyDrawer(),
    );
  }

  Widget _buildIconButton({
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Expanded(
      child: IconButton(
        iconSize: 24,
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
