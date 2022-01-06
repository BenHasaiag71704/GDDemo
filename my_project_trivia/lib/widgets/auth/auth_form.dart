import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  __AuthFormState createState() => __AuthFormState();
}

class __AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a valid email address.';
                      }
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a valid username.";
                      }
                      if (value.isEmpty || value.length < 4) {
                        return "Please enter at least 4 characters.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    onSaved: (value) {
                      _userName = value.toString();
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Please enter a valid password.";
                      }
                      if (value.isEmpty || value.length < 7) {
                        return "Please enter at least 7 characters.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value.toString();
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    child: const Text("Login"),
                    onPressed: _trySubmit,
                  ),
                  TextButton(
                    child: const Text("Create new account"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}