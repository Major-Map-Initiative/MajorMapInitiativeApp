import 'package:flutter/cupertino.dart';
import 'package:myapp/services/firebase_authentication_service.dart';

class UserProvider extends ChangeNotifier {
  FirebaseAuthenticationService _firebaseAuthenticationService;

  UserProvider() {
    _firebaseAuthenticationService = FirebaseAuthenticationService();
  }
  Future<String> login(String email, String password) async {
    return await _firebaseAuthenticationService.signIn(email, password);
  }

  Future<bool> isLoggedIn() async {
    return await _firebaseAuthenticationService.getCurrentUser() != null;
  }

  logOut() {
    _firebaseAuthenticationService.signOut();
  }

  Future<bool> signUp(String email, String password) async {
    if (await _firebaseAuthenticationService.signUp(email, password) == null) {
      return false;
    } else {
      return true;
    }
  }
}
