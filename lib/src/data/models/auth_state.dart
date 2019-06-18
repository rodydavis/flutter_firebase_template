import 'package:firebase/firebase.dart';
import 'package:flutter_web/material.dart';

import '../services/index.dart';

class AuthState extends ChangeNotifier {
  String _error = '';
  String get error => _error;
  bool get isLoggedIn => _cred != null;
  UserCredential _cred;

  bool _loading = false;
  bool get isLoading => _loading;

  void loginWithEmail(String email, String password) async {
    _error = '';
    _setLoading(true);
                            
    await Future.delayed(Duration(seconds: 3));
    try {
      _cred = await registerUser(email, password);
    } catch (e) {
      _error = e.toString();
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
