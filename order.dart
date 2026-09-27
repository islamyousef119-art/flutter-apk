enum OrderStatus {
  pending,
  accepted,
  pickedUp,
  onTheWay,
  delivered,
  cancelled,
}

class OrderItem {
  final String name;
  final int qty;
  final double price;

  const OrderItem({
    required this.name,
    required this.qty,
    required this.price,
  });

  Map<String, dynamic> toMap() => {'name': name, 'qty': qty, 'price': price};
}

class DeliveryOrder {
  final String id;
  final String customerName;
  final String restaurantName;
  final String customerAddress;
  final String restaurantAddress;
  final double customerLat;
  final double customerLng;
  final double restaurantLat;
  final double restaurantLng;
  final List<OrderItem> items;
  final double total;
  final OrderStatus status;
  final String? driverName;

  const DeliveryOrder({
    required this.id,
    required this.customerName,
    required this.restaurantName,
    required this.customerAddress,
    required this.restaurantAddress,
    required this.customerLat,
    required this.customerLng,
    required this.restaurantLat,
    required this.restaurantLng,
    required this.items,
    required this.total,
    required this.status,
    this.driverName,
  });

  DeliveryOrder copyWith({OrderStatus? status, String? driverName}) =>
      DeliveryOrder(
        id: id,
        customerName: customerName,
        restaurantName: restaurantName,
        customerAddress: customerAddress,
        restaurantAddress: restaurantAddress,
        customerLat: customerLat,
        customerLng: customerLng,
        restaurantLat: restaurantLat,
        restaurantLng: restaurantLng,
        items: items,
        total: total,
        status: status ?? this.status,
        driverName: driverName ?? this.driverName,
      );
}
