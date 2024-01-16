import 'package:flutter/material.dart';

import '../features/auth/services/get_firestore.dart';

class UserProvider extends ChangeNotifier {
  String? _userName;

  String? get userName => _userName;

  void setUser(String name) {
    _userName = name;
    notifyListeners();
  }
}
