import 'package:firebase/firebase.dart' as fb;

final auth = fb.auth();

void _init() {
  fb.initializeApp(
    apiKey: "AIzaSyDvczSfQ19pv5RaQicYn1hC-9JRFbkztkI",
    authDomain: "unify-connect-323c5.firebaseapp.com",
    databaseURL: "https://unify-connect-323c5.firebaseio.com",
    projectId: "unify-connect-323c5",
    storageBucket: "unify-connect-323c5.appspot.com",
    messagingSenderId: "424548644874",
    // appId: "1:424548644874:web:cff5286295ba81ca",
  );
}

Future<fb.UserCredential> registerUser(String email, String password) async {
  _init();
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
