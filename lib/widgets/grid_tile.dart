import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shop/detailspage.dart';
import 'package:shop/models/product.dart';

class GridProductTile extends StatefulWidget {
  final Product product;

  const GridProductTile({Key? key, required this.product}) : super(key: key);

  @override
  State<GridProductTile> createState() => _GridProductTileState();
}

class _GridProductTileState extends State<GridProductTile> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(product: widget.product),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    widget.product.imagePath1,
                    height: 200,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  widget.product.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.product.discount}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 7),
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Positioned(
            right: 15,
            top: 15,
            child: LikeButton(
              size: 20,
              bubblesColor: BubblesColor(
                  dotPrimaryColor: Colors.grey.shade100,
                  dotSecondaryColor: Colors.deepOrange,
                  dotThirdColor: Colors.blue,
                  dotLastColor: Colors.green),
              circleColor: CircleColor(
                  start: Colors.grey.shade100, end: Colors.deepOrange),
            ))
      ],
    );
  }
}
