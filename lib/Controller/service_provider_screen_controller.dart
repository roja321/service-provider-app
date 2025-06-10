import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceProviderScreenController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController experianceController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async{
    getUserServiceProviderProfiles();
    super.onInit();
  }

  saveProfile({name, phone, service, experiance}) async {
     if (name == null || name.isEmpty ||
         phone == null || phone.isEmpty ||
         service == null || service.isEmpty ||
     experiance == null || experiance.isEmpty
   ) {
       Get.snackbar(
         "Invalid Input",
         "All fields are required.",
         backgroundColor: Colors.red,
         colorText: Colors.white,
       );
     }
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw 'User not logged in';
      final data = {
        'name': name,
        'phone': phone,
        'services': service,
        'role': 'provider',
        'userId': uid,
        'experiance': experiance,
        // 'userId': uid, // Store user ID as field instead
        'email': _auth.currentUser?.email,
        'updatedAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('serviceprovider').add(data);
      // await _firestore.collection('serviceprovider').add(data);//multiple profile per user
      // await _firestore.collection('serviceprovider').doc(uid).set(data, SetOptions(merge: true));//single profile per user
      Get.snackbar(
        "Success",
        "Profile saved successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      getUserServiceProviderProfiles();
      nameController.clear();
      phoneNoController.clear();
      serviceController.clear();
      experianceController.clear();
    } catch (e) {
      print("error --${e}");
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
    }
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
          .where('userId', isEqualTo: uid)
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
      isDataPresent.value=true;
      print("Found1 ${serviceProviderData}");

    } catch (e) {
      isDataPresent.value=false;
      print("Error getting profiles: $e");
      // return [];
    }
  }

  // Future<void> loadProfile() async {
  //   final uid = _auth.currentUser?.uid;
  //   if (uid == null) return;
  //
  //   final doc = await _firestore.collection('serviceprovider').doc(uid).get();
  //   print("doc--${doc}");
  //   if (doc.exists) {
  //     print("doc1--${doc['name']}");
  //     print("doc1--${doc['services']}");
  //     isProfile.value=false;
  //     // nameController.value = doc['name'] ?? '';
  //     // phoneNoController.value = doc['phone'] ?? '';
  //     // serviceController.value = doc['services'] ?? '';
  //     // experianceController.value = doc['experiance'] ?? '';
  //
  //   }else{
  //     isProfile.value=true;
  //   }
  // }

}