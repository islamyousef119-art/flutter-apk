import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order.dart';

class OrderService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String?> createOrder(DeliveryOrder order) async {
    try {
      final ref = await db.collection('orders').add({
        'customerName': order.customerName,'restaurantName': order.restaurantName,
        'customerAddress': order.customerAddress,'restaurantAddress': order.restaurantAddress,
        'customerLat': order.customerLat,'customerLng': order.customerLng,
        'restaurantLat': order.restaurantLat,'restaurantLng': order.restaurantLng,
        'items': order.items.map((e)=>e.toMap()).toList(),'total': order.total,
        'status':'pending','driverName':null,'createdAt':FieldValue.serverTimestamp(),
      });
      return ref.id;
    } catch (_) { return null; }
  }

  Stream<QuerySnapshot<Map<String,dynamic>>> availableOrders()=>db.collection('orders').where('status',isEqualTo:'pending').snapshots();

  Future<bool> acceptOrder(String orderId,String driverId,String driverName) async {
    final ref=db.collection('orders').doc(orderId);
    try {
      return await db.runTransaction((tx) async {
        final snap=await tx.get(ref);
        if(!snap.exists || snap.data()?['status']!='pending') return false;
        tx.update(ref,{'status':'accepted','driverId':driverId,'driverName':driverName,'acceptedAt':FieldValue.serverTimestamp()});
        return true;
      });
    } catch (_) { return false; }
  }

  Future<void> updateStatus(String orderId,OrderStatus status,{String? driverName}) async {
    final data=<String,dynamic>{'status':status.name,'updatedAt':FieldValue.serverTimestamp()};
    if(driverName!=null)data['driverName']=driverName;
    await db.collection('orders').doc(orderId).update(data);
  }

  Stream<DocumentSnapshot<Map<String,dynamic>>> watchOrder(String id)=>db.collection('orders').doc(id).snapshots();
}
