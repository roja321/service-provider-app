import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ServiceProviderHomeController extends GetxController{
  var orders = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async{
    fetchBookings();
    super.onInit();
  }
  var bookings = <Map<String, dynamic>>[].obs;
  var statusMap = <String, RxString>{}.obs;
  Future<void> fetchBookings() async {
    final data = await FirebaseFirestore.instance.collection('bookings').get();

    bookings.value = data.docs.map((doc) {
      final map = doc.data();
      map['id'] = doc.id;

      // Setup status in the map with default if null
      statusMap[doc.id] = RxString(map['status'] ?? 'Pending');

      return map;
    }).toList();
  }

  void updateStatus(String bookingId, String newStatus) async {
    print("inside update");
    // Update local map
    if (statusMap.containsKey(bookingId)) {
      statusMap[bookingId]?.value = newStatus;
    }

    // Update in Firestore
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(bookingId)
        .update({'status': newStatus});
  }

  // RxList<Map<String, dynamic>> bookings = <Map<String, dynamic>>[].obs;
  // Future<void> fetchBookings() async {
  //   try {
  //     final snapshot = await FirebaseFirestore.instance
  //         .collection('bookings')
  //         .get();
  //
  //     final data = snapshot.docs
  //         .map((doc) => doc.data() as Map<String, dynamic>)
  //         .toList();
  //    bookings.value = data;
  //     print("bookings.value--${bookings.value}");
  //   } catch (e) {
  //     print('Error fetching bookings: $e');
  //
  //   }
  // }
  //
  // var statusMap = <String, RxString>{}.obs;
  // void setStatus(String docId, String status) {
  //   statusMap[docId] = status.obs;
  // }
  //
  // Future<void> updateStatus(String docId, String newStatus) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('bookings')
  //         .doc(docId)
  //         .update({'status': newStatus});
  //
  //     statusMap[docId]?.value = newStatus;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to update status: $e');
  //   }
  // }
}