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
  TextEditingController descriptionController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController minChargeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() async{
    getUserServiceProviderProfiles();
    super.onInit();
  }

  saveProfile({name, phone, service, experiance,description,skills,address,minimumCharge}) async {
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
       Navigator.of(Get.context!, rootNavigator: true).pop();
     }else {
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
           'experiance': experiance,
           'skills': skills,
           'address': address,
           'minimumCharge': minimumCharge
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

         Navigator.of(Get.context!).pop();
         await getUserServiceProviderProfiles();
         Navigator.of(Get.context!, rootNavigator: true).pop();

         nameController.clear();
         phoneNoController.clear();
         serviceController.clear();
         experianceController.clear();
         skillController.clear();
         descriptionController.clear();
         minChargeController.clear();
         addressController.clear();
       } catch (e) {
         Navigator.of(Get.context!, rootNavigator: true).pop();
         Get.snackbar(
           "Error",
           "Something went wrong",
           backgroundColor: Colors.red,
           colorText: Colors.white,
         );
       }
     }

  }



  RxList<Map<String, dynamic>> serviceProviderData = <Map<String, dynamic>>[].obs;
  var isDataPresent=false.obs;
  Future getUserServiceProviderProfiles() async {
    serviceProviderData.value.clear();
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) throw 'User not logged in';

     final querySnapshot = await _firestore
          .collection('serviceprovider')
          .where('userId', isEqualTo: uid)
          .get();
      List<Map<String, dynamic>> tempList = [];
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;

          print("before list--${serviceProviderData.value}");
          tempList.add({
            'id': doc.id,
            ...data,
          });

        }
        serviceProviderData.value = tempList;
        print("after list--${serviceProviderData.value}");
      }
      isDataPresent.value=true;

    } catch (e) {
      isDataPresent.value=false;
    }
  }

  delete({var providerData, required BuildContext context}) async {
    try {
      String documentId;

      if (providerData is String) {
        // If you're passing just the string, it should be the document ID
        documentId = providerData;
      }  else {
        Get.snackbar('Error', 'Invalid data format');
        return;
      }
      // Check if document exists
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('serviceprovider')
          .doc(documentId)
          .get();

      if (!doc.exists) {
        Get.snackbar('Error', 'Document not found');
        Navigator.of(Get.context!).pop();
      }

      // Delete the document
      await FirebaseFirestore.instance
          .collection('serviceprovider')
          .doc(documentId)
          .delete();
      Get.snackbar(
        "Success",
        "Service provider deleted successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
     await getUserServiceProviderProfiles();
      Navigator.of(context).pop();

      Navigator.of(Get.context!, rootNavigator: true).pop();
      // Refresh your list


    } catch (e) {
      Get.snackbar('Error', 'Delete failed: $e');
      Navigator.of(Get.context!, rootNavigator: true).pop();}
  }

}