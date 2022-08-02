import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jochat/pages/chatpage.dart';
import 'package:jochat/utils/settings.dart';

class UsernameForm extends StatefulWidget {
  const UsernameForm({Key? key}) : super(key: key);

  @override
  State<UsernameForm> createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  bool loading = false;

  @override
  void initState() {
    if (user.displayName != null) {
      setState(() {
        _usernameController.text = user.displayName!;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: user.displayName != null
            ? const Text('Update Username')
            : const Text('Username needed'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              user.displayName != null
                  ? const Text(
                      'Enter your new username below and continue chatting.\nDon\'t want to change username? Just press Cancel.')
                  : const Text(
                      "You must enter a username to start using the chat. \nPlease enter a username of your liking below."),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your username here",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: primarycolor,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          user.displayName == null
              ? const SizedBox()
              : TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
          TextButton(
            child: loading
                ? const CircularProgressIndicator()
                : const Text('Set Username'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                EasyLoading.show(status: 'Loading..');
                try {
                  await user
                      .updateDisplayName(_usernameController.text)
                      .then((value) {
                    EasyLoading.dismiss();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  });
                } on FirebaseAuthException catch (e) {
                  var snackBar = SnackBar(
                    content: Text('${e.message}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  EasyLoading.dismiss();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
