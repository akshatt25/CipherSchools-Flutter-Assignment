import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUid(String uid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userUid', uid);
}

Future<String?> getUid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userUid');
}
