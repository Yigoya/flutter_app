import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/components/my_bottun.dart';
import 'package:untitled/components/my_textfield.dart';
import 'package:untitled/service/auth/auth_service.dart';
class LoginPage extends StatefulWidget {
  final void Function()? onTop;
  const LoginPage({super.key, required this.onTop});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message, size: 80, color: Colors.grey[800]),
                SizedBox(
                  height: 30,
                ),
                const Text("welcome you have missed"),
                SizedBox(
                  height: 30,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: "password",
                    obscureText: true),
                SizedBox(
                  height: 25,
                ),
                MyButton(onTop: signIn, text: "Login"),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text("Not a member?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTop,
                      child: Text(
                        "Register now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
