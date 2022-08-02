import 'package:flutter/material.dart';
import 'package:jochat/components/forgotpasswordform.dart';
import 'package:jochat/utils/settings.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarybgcolor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('assets/images/logo.png'),
                width: 200,
              ),
              Text(
                "Reset Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Text(
                  'You\'ll receive an email to reset your password after entering your email and pressing the reset password button.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 15),
              ForgotPasswordForm(),
            ],
          ),
        ),
      ),
    );
  }
}
