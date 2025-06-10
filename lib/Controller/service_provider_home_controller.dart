import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ServiceProviderHomeController extends GetxController{
  var orders = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void fetchOrders(String providerId) {
    _firestore
        .collection('orders')
        .where('providerId', isEqualTo: providerId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      orders.value = snapshot.docs.map((doc) {
        return {"id": doc.id, ...doc.data() as Map<String, dynamic>};
      }).toList();
    });
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
    });
  }
}