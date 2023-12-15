import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/login.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        accountName: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Asif Faizal'.toUpperCase(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        currentAccountPicture: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('lib/assets/torso.jpg'),
        ),
        accountEmail: null,
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onTap: () {
          if (title == 'LOGOUT') {
            _signOut(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(
                  'Logged Out Succesfully',
                )));
          } else {}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          _buildDrawerHeader(context),
          _buildDrawerItem(
            context: context,
            title: 'LOGOUT',
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }
}
