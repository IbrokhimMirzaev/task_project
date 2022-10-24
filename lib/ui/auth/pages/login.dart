import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onClickSignUp}) : super(key: key);

  final VoidCallback onClickSignUp;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(height: 100),
            TextButton(onPressed: signIn, child: Text("Sign in")),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: widget.onClickSignUp,
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    context.read<AuthCubit>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
