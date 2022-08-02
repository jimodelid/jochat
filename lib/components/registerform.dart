import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jochat/main.dart';
import 'package:jochat/utils/settings.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _emailController,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[ ]')),
              ],
              decoration: const InputDecoration(
                hintText: "Enter your email here",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primarycolor,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(value)) {
                  return 'Please provide a valid email adress';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: "Enter your password here",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primarycolor,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                if (value.length < 7) {
                  return 'Password must be at least 7 characters long.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: secondarycolor, // This is what you need!
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _signUp();
                }
              },
              child: const Text("Register"),
            ),
          )
        ],
      ),
    );
  }

  Future _signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(
        content: Text('${e.message}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
