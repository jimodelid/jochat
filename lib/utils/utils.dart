import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future signOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Utils.showSnackbar('You have been signed out.');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    }
  }

  static Future sendMessage(user, message) async {
    if (user.displayName != null) {
      tz.initializeTimeZones();
      var swedishTimezone = tz.getLocation('Europe/Stockholm');
      var now = tz.TZDateTime.now(swedishTimezone);

      var finalDate = "${now.day}/${now.month}-${now.year}";
      FirebaseFirestore.instance.collection("messages").add({
        'date': finalDate,
        'message': message,
        'name': user.displayName,
        'sender': user.uid,
        'sorting': now
      });
    } else {
      Utils.showSnackbar(
          'You must choose a username on the user icon in the top right in order to send a message.');
    }
  }
}
