import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceProviderHomeController extends GetxController{
  var orders = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async{
    fetchBookings();
    super.onInit();
  }
  // Updated Controller Code
  var bookings = <Map<String, dynamic>>[].obs;
  var statusMap = <String, RxString>{}.obs;

// Add these new variables for filtering
  var filteredBookings = <Map<String, dynamic>>[].obs;
  var selectedFilter = 'All'.obs; // 'All', 'Completed', 'Pending', 'Hold'

  Future<void> fetchBookings() async {
    final data = await FirebaseFirestore.instance.collection('bookings').get();

    bookings.value = data.docs.map((doc) {
      final map = doc.data();
      map['id'] = doc.id;

      // Setup status in the map with default if null
      statusMap[doc.id] = RxString(map['status'] ?? 'Pending');

      return map;
    }).toList();

    // Apply initial filter
    applyFilter();
  }

// Method to apply filter based on selected status
  void applyFilter() {
    if (selectedFilter.value == 'All') {
      filteredBookings.value = List.from(bookings);
    } else {
      filteredBookings.value = bookings.where((booking) {
        final currentStatus = statusMap[booking['id']]?.value ?? 'Pending';
        return currentStatus == selectedFilter.value;
      }).toList();
    }
  }

// Method to change filter
  void changeFilter(String filter) {
    selectedFilter.value = filter;
    applyFilter();
  }

// Update the existing updateStatus method to refresh filtered list
  void updateStatus1(String id, String newStatus) async {
    // Update the status in the map
    statusMap[id]?.value = newStatus;

    // Update in Firestore
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(id)
        .update({'status': newStatus});

    // Refresh the filtered list
    applyFilter();
  }

  // var bookings = <Map<String, dynamic>>[].obs;
  // var statusMap = <String, RxString>{}.obs;
  // Future<void> fetchBookings() async {
  //   final data = await FirebaseFirestore.instance.collection('bookings').get();
  //
  //   bookings.value = data.docs.map((doc) {
  //     final map = doc.data();
  //     map['id'] = doc.id;
  //
  //     // Setup status in the map with default if null
  //     statusMap[doc.id] = RxString(map['status'] ?? 'Pending');
  //
  //     return map;
  //   }).toList();
  // }

  void updateStatus(String bookingId, String newStatus) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      // Optional: Debug print current booking document
      final bookingDoc = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .get();
      // Proceed with update
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({'status': newStatus});
      Get.snackbar("Successful", "Status updated Successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      applyFilter();
    } catch (e) {
      Get.snackbar("Error", "Something Went Wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      print("Firestore update failed: $e");
    }
  }

// void updateStatus(String bookingId, String newStatus) async {
  //   print("inside update   ${bookingId}   ${newStatus}");
  //   try {
  //     // Update local map
  //     if (statusMap.containsKey(bookingId)) {
  //       statusMap[bookingId]?.value = newStatus;
  //     }
  //
  //     final user = FirebaseAuth.instance.currentUser;
  //     print("Current user UID: ${user?.uid}");
  //     final uid = FirebaseAuth.instance.currentUser?.uid;
  //     final doc = await FirebaseFirestore.instance
  //         .collection('serviceprovider')
  //         .doc(uid)
  //         .get();
  //
  //     print("Role in serviceprovider doc: ${doc.data()?['role']}");
  //
  //
  //     // Update in Firestore
  //     await FirebaseFirestore.instance
  //         .collection('bookings')
  //         .doc(bookingId)
  //         .update({'status': newStatus});
  //   } catch (e) {
  //     print("inside catch-${e}");
  //   }
  // }
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