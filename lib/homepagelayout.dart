import 'package:flutter/material.dart';
import 'package:shop/pages/denim.dart';
import 'package:shop/pages/formals.dart';
import 'package:shop/pages/party.dart';
import 'package:shop/pages/play.dart';
import 'package:shop/pages/winter_sale.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WinterSale()));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Image.asset('lib/assets/sale.jpg'),
              const Positioned(
                bottom: 20,
                child: Text(
                  'WINTER SALE',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              )
            ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DenimPage()));
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Stack(alignment: Alignment.center, children: [
              Image.asset('lib/assets/denim.jpg'),
              Text(
                'CHOOSE YOUR DENIM FIT',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              )
            ]),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SportsPage()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Stack(alignment: Alignment.center, children: [
              Image.asset('lib/assets/sports.jpg'),
              Text(
                'play hard'.toUpperCase(),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ]),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PartyPage()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            child: Stack(alignment: Alignment.center, children: [
              Image.asset('lib/assets/party.jpg'),
              Text(
                'party hard'.toUpperCase(),
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FormalsPage()));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Stack(alignment: Alignment.center, children: [
              Image.asset('lib/assets/formal.jpg'),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'timeless'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(
                    height: 350,
                  ),
                  Text(
                    'formals'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
