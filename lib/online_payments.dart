import 'package:flutter/material.dart';

class OnlinePaymentScreen extends StatelessWidget {
  final int totalAmount;
  const OnlinePaymentScreen({Key? key, required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        foregroundColor: Colors.deepOrange,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Text(
          'Pay Online',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.deepOrange,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return GridTile(
              child: _buildGridItem(index),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.deepOrange,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Proceed to Pay \$$totalAmount',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    List<String> assetImagePaths = [
      'lib/assets/payments/gpay.png',
      'lib/assets/payments/paytm.png',
      'lib/assets/payments/phonepe.png',
      'lib/assets/payments/visa.png',
    ];

    List<String> labelTexts = [
      'Google Pay',
      'Pay TM',
      'Phone Pe',
      'Cards',
    ];

    String assetImagePath = assetImagePaths[index];
    String labelText = labelTexts[index];

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0.5),
          ),
        ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(assetImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange.withOpacity(.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: Text(
              labelText,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
