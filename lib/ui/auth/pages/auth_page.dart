import 'package:flutter/material.dart';
import 'package:task_project/ui/auth/pages/login.dart';
import 'package:task_project/ui/auth/pages/sign_up.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogged = true;

  @override
  Widget build(BuildContext context) {
    return isLogged ? LoginPage(onClickSignUp: switchAuthPages) : SignUpPage(onClickedSignIn: switchAuthPages);
  }
  void switchAuthPages() => setState(() {
    isLogged = !isLogged;
  });
}
