import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/data/cubits/auth_cubit/auth_cubit.dart';
import 'package:task_project/utils/my_utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.onClickedSignIn}) : super(key: key);

  final VoidCallback onClickedSignIn;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Email"),
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                  email != null && !EmailValidator.validate(email) ? "Enter a valid email" : null,
                  style: const TextStyle(fontSize: 17),
                  // decoration: getInputDecoration(label: "Email"),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                    decoration: const InputDecoration(hintText: "Password"),
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (password) => password != null && password.length < 6 ? "Enter at least 6 charcter !" : null,
                    style: const TextStyle(fontSize: 17,)
                  // decoration: getInputDecoration(label: "Password"),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Confirm Password"),
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                  password != null && password.length < 6 ? "Enter at least 6 charcter !" : null,
                ),
              ),
              const SizedBox(height: 50),
              TextButton(onPressed: signUp, child: const Text("Sign Up", style: TextStyle(fontSize: 30))),
              const SizedBox(height: 20),
              TextButton(
                onPressed: widget.onClickedSignIn,
                child: const Text("Log in", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (confirmPassword == password) {
      context.read<AuthCubit>().signUp(email: email, password: password, context: context);
    } else {
      MyUtils.getMyToast(message: "Passwords don't match!");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
