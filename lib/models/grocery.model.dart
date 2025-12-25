class Grocery {
  final int? id;
  final String? name;
  final String? description;
  final double? price;
  final String? imagePath;
  Grocery({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

var items = [
  Grocery(
    id: 1,
    name: 'Organic Banana',
    description: '1Kg',
    price: 4.99,
    imagePath: 'assets/images/grocery_images/banana.png',
  ),
  Grocery(
    id: 2,
    name: 'Apple',
    description: '1Kg',
    price: 4.99,
    imagePath: 'assets/images/grocery_images/apple.png',
  ),
  Grocery(
    id: 3,
    name: 'Beef',
    description: '1Kg',
    price: 19.99,
    imagePath: 'assets/images/grocery_images/beef.png',
  ),
  Grocery(
    id: 4,
    name: 'Chicken',
    description: '1Kg',
    price: 6.99,
    imagePath: 'assets/images/grocery_images/chicken.png',
  ),
  Grocery(
    id: 5,
    name: 'Ginger',
    description: '1Kg',
    price: 7.99,
    imagePath: 'assets/images/grocery_images/ginger.png',
  ),
  Grocery(
    id: 6,
    name: 'Pepper',
    description: '1Kg',
    price: 9.99,
    imagePath: 'assets/images/grocery_images/pepper.png',
  ),
];
