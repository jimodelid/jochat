import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jochat/pages/chatpage.dart';
import 'package:jochat/utils/settings.dart';
import 'package:jochat/utils/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
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
                  _signIn();
                }
              },
              child: const Text("Login"),
            ),
          )
        ],
      ),
    );
  }

  Future _signIn() async {
    EasyLoading.show(status: 'Loading..');

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )
          .then((value) {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatPage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    }

    EasyLoading.dismiss();
  }
}
