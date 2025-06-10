import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerScreenController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async{
    getUserServiceProviderProfiles();
    super.onInit();
  }

  List<Map<String, dynamic>> serviceProviderData = [];

  var isDataPresent=false.obs;
  Future getUserServiceProviderProfiles() async {
    serviceProviderData.clear();
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw 'User not logged in';

      final querySnapshot = await _firestore
          .collection('serviceprovider')
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          serviceProviderData.add({
            'id': doc.id,
            ...data,
          });
        }
      }
      filteredData.value = serviceProviderData;
      isDataPresent.value=true;
      print("Found1 ${filteredData.value}");

    } catch (e) {
      isDataPresent.value=false;
      print("Error getting profiles: $e");
      // return [];
    }
  }
  var searchQuery = ''.obs;
  var filteredData = <Map<String, dynamic>>[].obs;

  void searchByService(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      // ⭐ RESET TO SHOW ALL DATA (instead of clearing)
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
}