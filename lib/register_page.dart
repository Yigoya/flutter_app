import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/components/my_bottun.dart';
import 'package:untitled/components/my_textfield.dart';
import 'package:untitled/service/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTop;
  const RegisterPage({super.key, required this.onTop});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
          emailController.text,
          passwordController.text,
          nameController.text,
          phoneController.text,
          accountController.text);
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
                Icon(Icons.help_center, size: 80, color: Colors.grey[800]),
                const SizedBox(
                  height: 30,
                ),
                const Text("Lets Create an account for you"),
                const SizedBox(
                  height: 30,
                ),
                MyTextField(
                    controller: nameController,
                    hintText: "Your name",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: phoneController,
                    hintText: "phone number",
                    obscureText: false),
                MyTextField(
                    controller: accountController,
                    hintText: "account number",
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: passwordController,
                    hintText: "password",
                    obscureText: true),
                MyTextField(
                    controller: confirmPasswordController,
                    hintText: "confirm password",
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                MyButton(onTop: signUp, text: "Sign up"),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text("Already a member?"),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTop,
                      child: Text(
                        "login now",
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
