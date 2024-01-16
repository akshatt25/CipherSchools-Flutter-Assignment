import 'package:firebase_auth/firebase_auth.dart';

void validation() {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    print("no user");
  } else {
    print('user is in ${currentUser.uid}');
    // Navigate to home page
  }
}
