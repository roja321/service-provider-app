import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle user signup
  Future<String?> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      // Create user in Firebase Authentication with email and password
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Save additional user data (name, role) in Firestore
      await _firestore.collection('customer').doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'role': role, // Role determines if user is Admin or User
      });

      return null; // Success: no error message
    } catch (e) {
      return e.toString(); // Error: return the exception message
    }
  }

  // Function to handle user login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user using Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Fetch the user's role from Firestore to determine access level
      DocumentSnapshot userDoc = await _firestore
          .collection('customer')
          .doc(userCredential.user!.uid)
          .get();
      String customerId = userCredential.user!.uid;
      // String customerName = userCredential.user?.name;

      // Store customer ID in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('customerId', customerId);
      // await prefs.setString('customerName', customerName);
print("get id from shell--${prefs.getString('customerId')}");
      return userDoc['role']; // Return the user's role (Admin/User)
    } catch (e) {
      return e.toString(); // Error: return the exception message
    }
  }

  // for user log out
  signOut() async {
    _auth.signOut();
  }


}