import 'package:firebase/firebase.dart' as fb;

final auth = fb.auth();

Future<fb.UserCredential> registerUser(String email, String password) async {
  if (email.isNotEmpty && password.isNotEmpty) {
    var trySignin = false;
    try {
      // Modifies persistence state. More info: https://firebase.google.com/docs/auth/web/auth-state-persistence
      var selectedPersistence = 'local';
      await auth.setPersistence(selectedPersistence);
      final _user = await auth.createUserWithEmailAndPassword(email, password);
      if (_user != null) return _user;
    } catch (e) {
      if (e.code == "auth/email-already-in-use") {
        trySignin = true;
      } else {
        throw e;
      }
    }

    if (trySignin) {
      try {
        final _user = await auth.signInWithEmailAndPassword(email, password);
        if (_user != null) return _user;
      } catch (e) {
        throw e;
      }
    }
  } else {
    throw "Please fill correct e-mail and password.";
  }
  throw 'Error Communicating with Firebase';
}
