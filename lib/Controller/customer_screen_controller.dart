import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerScreenController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
TextEditingController instructionController = TextEditingController();
TextEditingController adressController = TextEditingController();
TextEditingController customerAdressController = TextEditingController();

  @override
  void onInit() async{
    getUserServiceProviderProfiles();
    super.onInit();
  }

  List<Map<String, dynamic>> serviceProviderData = [];

  var isDataPresent=false.obs;

  Future<void> getUserServiceProviderProfiles() async {
   print("inside getUserServiceProviderProfiles");
    serviceProviderData.clear();

    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw 'User not logged in';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getString('customerId'); // current user ID
      if (customerId == null) throw 'Customer ID not found';

      final providerQuery = await _firestore.collection('serviceprovider').get();

      for (var doc in providerQuery.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final providerId = doc.id;

        // Check if booking exists for this provider from this customer
        final bookingQuery = await _firestore
            .collection('bookings')
            .where('serviceProviderId', isEqualTo: providerId)
            .where('customerId', isEqualTo: customerId)
            .get();

        String bookingStatus = "not booked";
        if (bookingQuery.docs.isNotEmpty) {
          bookingStatus = bookingQuery.docs.first.data()['status'] ?? "unknown";
        }

        // Add provider + booking status
        serviceProviderData.add({
          'id': providerId,
          ...data,
          'bookingStatus': bookingStatus,
        });
      }

      // Reflect updated list in your filtered observable
      filteredData.value = serviceProviderData;
      isDataPresent.value = true;
print("filteredData.value--${filteredData.value}");
print("isDataPresent.value--${isDataPresent.value}");
    } catch (e) {
      isDataPresent.value = false;
      print("Error: $e");
    }
  }

  var searchQuery = ''.obs;
  var filteredData = <Map<String, dynamic>>[].obs;

  void searchByService(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      // RESET TO SHOW ALL DATA (instead of clearing)
      filteredData.value = List.from(serviceProviderData);
    } else {
      // Filter data based on search query
      filteredData.value = serviceProviderData.where((provider) {
        final service = provider['services']?.toString().toLowerCase() ?? '';
        final name = provider['name']?.toString().toLowerCase() ?? '';
        final searchLower = query.toLowerCase();

        // Search in both service and name fields
        return service.contains(searchLower) || name.contains(searchLower);
      }).toList();
    }

    print("Search query: '$query' - Results: ${filteredData.value.length}");
  }

  Future<String?> createBooking(Map<String, dynamic> bookingData) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      // ✅ Add userId for Firestore rule check
      bookingData['userId'] = user.uid;
      bookingData['createdAt'] = DateTime.now();
      bookingData['updatedAt'] = DateTime.now();

      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('bookings')
          .add(bookingData);

      return docRef.id;
    } catch (e) {
      print('Error creating booking: $e');
      return null;
    }
  }
}
