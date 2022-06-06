import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFN);
  final void Function(
    String email,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFN;

  @override
  __AuthFormState createState() => __AuthFormState();
}

class __AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  // String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFN(
          _userEmail.trim(), _userPassword.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        color: (Color(0xffebf0f7)),
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
                    style: TextStyle(color: Colors.black),
                    key: ValueKey('email'),
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
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      labelText: 'Email address',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  // if (!_isLogin)
                  // TextFormField(
                  //   key: ValueKey('username'),
                  //   validator: (value) {
                  //     if (value == null) {
                  //       return "Please enter a valid username.";
                  //     }
                  //     if (value.isEmpty || value.length < 4) {
                  //       return "Please enter at least 4 characters.";
                  //     }
                  //     return null;
                  //   },
                  //   decoration: const InputDecoration(
                  //     labelText: 'Username',
                  //   ),
                  //   onSaved: (value) {
                  //     _userName = value.toString();
                  //   },
                  // ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    key: ValueKey('password'),
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
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
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
                    child: Text(_isLogin ? "Login" : 'Singup'),
                    onPressed: _trySubmit,
                  ),
                  TextButton(
                    child: Text(
                      _isLogin
                          ? "Create new account"
                          : "I already have an account",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
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
