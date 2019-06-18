import 'package:flutter_firebase_template/src/data/models/index.dart';
import 'package:flutter_firebase_template/src/data/services/index.dart';
import 'package:flutter_web/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, auth, child) => Scaffold(
            appBar: AppBar(
              title: Text('Login Screen'),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: _username,
                          decoration: InputDecoration(labelText: 'Usename'),
                          autocorrect: false,
                          validator: (val) =>
                              val.isNotEmpty ? null : 'Username Required',
                          onSaved: (val) => _username = val,
                        ),
                        TextFormField(
                          initialValue: _password,
                          decoration: InputDecoration(labelText: 'Password'),
                          autocorrect: false,
                          obscureText: true,
                          validator: (val) =>
                              val.isNotEmpty ? null : 'Password Required',
                          onSaved: (val) => _password = val,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(
                            child: Text('Login'),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                auth.loginWithEmail(_username, _password);
                              }
                            },
                          ),
                        ),
                        if (auth.isLoading) ...[CircularProgressIndicator()],
                        if (auth.error.isNotEmpty) ...[Text(auth.error)],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
