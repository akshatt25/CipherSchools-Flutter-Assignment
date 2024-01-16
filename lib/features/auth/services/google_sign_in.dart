import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/main/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../local/save_user.dart';
import '../../main/widgets/bottom_nav.dart';

Future<void> signUpWithGoogle({required BuildContext context}) async {
  try {
    // Google Sign-In
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    if (googleSignInAccount == null) {
      print('Google Sign-In canceled.');
      return;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = authResult.user;

    if (user != null) {
      await saveUid(user.uid);

      // Create Firestore Document
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
      });
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, BottomBar.routeName,
          arguments: user.uid);
      print('User signed in and document created!');
    } else {
      print('Sign in failed.');
    }
  } catch (error) {
    print(error);
  }
}
