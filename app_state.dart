import 'package:flutter/foundation.dart';
import '../models/catalog.dart';
import '../models/order.dart';
import 'demo_data.dart';

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();
  AppState._();

  final List<CartLine> cart = [];
  DeliveryOrder? activeOrder;
  bool driverOnline = true;
  final List<String> favorites = [];

  double get subtotal => cart.fold(0, (s, x) => s + x.total);
  int get itemCount => cart.fold(0, (s, x) => s + x.quantity);
  double get deliveryFee => cart.isEmpty ? 0 : 15;
  double get total => subtotal + deliveryFee;

  void add(MenuItem item) {
    final found = cart.where((x) => x.item.id == item.id).firstOrNull;
    if (found == null) cart.add(CartLine(item: item)); else found.quantity++;
    notifyListeners();
  }
  void remove(MenuItem item) {
    final found = cart.where((x) => x.item.id == item.id).firstOrNull;
    if (found == null) return;
    if (found.quantity > 1) found.quantity--; else cart.remove(found);
    notifyListeners();
  }
  void toggleFavorite(String id) { favorites.contains(id) ? favorites.remove(id) : favorites.add(id); notifyListeners(); }
  void placeOrder(Restaurant restaurant, String address) {
    activeOrder = DeliveryOrder(id:'NOVA-${1000 + DateTime.now().millisecondsSinceEpoch % 9000}',customerName:'عميل نوفا',restaurantName:restaurant.name,customerAddress:address,restaurantAddress:restaurant.address,customerLat:30.7160,customerLng:31.2590,restaurantLat:30.7070,restaurantLng:31.2550,items:cart.map((x)=>OrderItem(name:x.item.name,qty:x.quantity,price:x.item.price)).toList(),total:total,status:OrderStatus.pending,driverName:null);
    cart.clear(); notifyListeners();
  }
  void setStatus(OrderStatus status, {String? driver}) { if(activeOrder != null) activeOrder = activeOrder!.copyWith(status:status,driverName:driver); notifyListeners(); }
  List<Restaurant> get allRestaurants => DemoData.restaurants;
}
