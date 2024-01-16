import 'package:expense_tracker/widgets/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../local/save_user.dart';
import '../../main/screens/home_screen.dart';
import '../../main/widgets/bottom_nav.dart';

Future<void> login(
    {required BuildContext context,
    required String email,
    required String password}) async {
  try {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Login successful, you can access user information using userCredential.user
    String uid = userCredential.user!.uid;
    await saveUid(uid);

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, BottomBar.routeName, arguments: uid, (route) => false);
    print('Login successful: ${userCredential.user?.uid}');
  } on FirebaseException catch (e) {
    showSnackBar(context: context, text: 'Invalid Mail or Password');
    print(e.message);
    // if () {
    //   // User not found, handle accordingly
    //   showSnackBar(context: context, text: e.message.toString());
    //   print('User not found');
    // } else {
    //   showSnackBar(context: context, text: 'Incorrect Password');
    //   // Handle other login errors
    //   print('Login failed: $e');
    // }
  }
}
