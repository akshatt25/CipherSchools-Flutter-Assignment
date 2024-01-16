import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signOutAndClearPrefs() async {
  // Sign out from Firebase
  await FirebaseAuth.instance.signOut();

  // Clear shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userUid');

  // Alternatively, if you want to clear all preferences
  // await prefs.clear();
}
