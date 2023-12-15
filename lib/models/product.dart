class Product {
  final String name;
  final String discount;
  final int price;
  final String description;
  final String imagePath1;
  final String imagePath2;
  final String imagePath3;
  final String imagePath4;
  Product(
      {required this.name,
      required this.discount,
      required this.price,
      required this.description,
      required this.imagePath1,
      required this.imagePath2,
      required this.imagePath3,
      required this.imagePath4});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'discount': discount,
      'price': price,
      'description': description,
      'imagePath1': imagePath1,
      'imagePath2': imagePath2,
      'imagePath3': imagePath3,
      'imagePath4': imagePath4,
    };
  }
}
