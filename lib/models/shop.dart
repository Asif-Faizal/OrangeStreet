import 'package:shop/models/product.dart';

class Shop {
  //product for sale
  final List<Product> _shop = [
    Product(
        name: 'shirt 1',
        discount: '',
        price: 1000,
        description: 'good shirt',
        imagePath1: 'lib/assets/1.jpeg',
        imagePath2: '',
        imagePath3: '',
        imagePath4: '')
  ];
  //user cart
  List<Product> _cart = [];

  //get product list
  List<Product> get shop => _shop;

  //get user cart
  List<Product> get cart => _cart;

  //add item to cart
  void addToCart(Product item) {
    _cart.add(item);
  }

  //remove item from cart
  void DeleteFromCart(Product item) {
    _cart.remove(item);
  }
}
