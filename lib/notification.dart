import 'package:flutter/material.dart';
import 'package:shop/cart.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/wishlist.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        foregroundColor: Colors.deepOrange,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'Updates'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.deepOrange),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Wishlist()));
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.deepOrange,
                  )),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Cart()));
                  },
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.deepOrange,
                  ))
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: SaleNotification(
                  title: 'Flash Sale!',
                  description: 'Hurry up! 50% off on selected items!',
                  onDelete: () {
                    setState(() {});
                  },
                ),
              );
            } else if (index == 1) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: SaleNotification(
                  title: 'Weekend Special',
                  description: 'Exclusive deals for the weekend. Shop now!',
                  onDelete: () {
                    setState(() {});
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class SaleNotification extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onDelete;

  const SaleNotification({
    Key? key,
    required this.title,
    required this.description,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          Icons.notifications_active,
          color: Colors.deepOrange,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        onTap: () {},
        trailing: Icon(
          Icons.delete_rounded,
          color: Colors.deepOrange,
          size: 20,
        ),
      ),
    );
  }
}
