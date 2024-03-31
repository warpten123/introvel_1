import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  int storedUserId = 0;

  void storeUser(int id) {
    storedUserId = id;

    notifyListeners();
  }

  void clearUser() {
    storedUserId = 0;
    notifyListeners();
  }

  int getStoredUserId() {
    return storedUserId;
  }
}
