import 'package:expense_tracker/features/main/screens/home_screen.dart';
import 'package:expense_tracker/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../local/save_user.dart';
import '../../main/widgets/bottom_nav.dart';

Future<void> signUp(
    {required BuildContext context,
    required String name,
    required String email,
    required String password}) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String uid = userCredential.user!.uid;
    await saveUid(uid);

    // Create a document in Firestore with the user's information
    await firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
    });

    Navigator.pushReplacementNamed(context, BottomBar.routeName,
        arguments: uid);

    print('User created: ${userCredential.user!.uid}');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      showSnackBar(
          context: context, text: "User already exists, Please Login!");
      print('The account already exists for that email.');
      // You can show a relevant error message to the user or handle it as needed.
    } else {
      showSnackBar(context: context, text: 'Try Again Later');
      print('Failed to create user: $e');
    }
  }
}
