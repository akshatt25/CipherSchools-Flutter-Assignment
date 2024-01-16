import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getFirestoreData(String userId) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (doc.exists) {
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    print('this is userdata ${userData}');
    return userData;
  } else {
    return {'error': 'Document not found'};
  }
}
