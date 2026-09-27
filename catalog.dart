class Restaurant {
  final String id, name, category, address, image;
  final double rating, deliveryFee;
  final int eta;
  final List<MenuItem> menu;
  const Restaurant({required this.id, required this.name, required this.category, required this.address, required this.image, required this.rating, required this.deliveryFee, required this.eta, required this.menu});
}

class MenuItem {
  final String id, name, description;
  final double price;
  const MenuItem({required this.id, required this.name, required this.description, required this.price});
}

class CartLine {
  final MenuItem item;
  int quantity;
  CartLine({required this.item, this.quantity = 1});
  double get total => item.price * quantity;
}
