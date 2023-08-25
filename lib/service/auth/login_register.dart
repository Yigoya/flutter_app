import 'package:flutter/material.dart';
import 'package:untitled/login_page.dart';
import 'package:untitled/register_page.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showLoginPage = true;
  void toggle() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTop: toggle,
      );
    } else {
      return RegisterPage(
        onTop: toggle,
      );
    }
  }
}
