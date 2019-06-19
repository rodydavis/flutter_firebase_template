import 'package:flutter_firebase_template/src/data/models/index.dart';
import 'package:flutter_web/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/firebase.dart' as fb;

import 'src/ui/index.dart';

void main() {
  fb.initializeApp(
    apiKey: "API_KEY",
    authDomain: "AUTH_DOMAIN",
    databaseURL: "DATABASE_URL",
    projectId: "PROJECT_ID",
    storageBucket: "STORAGE_BUCKET",
    messagingSenderId: "MESSAGE_SENDER_ID",
    // appId: "APP_ID",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableProvider.value(
      value: AuthState(),
      child: Consumer<AuthState>(
        builder: (context, auth, child) {
          if (!auth.isLoggedIn) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData.light(),
              home: LoginScreen(),
            );
          }
          return MultiProvider(
            providers: [],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData.dark(),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
