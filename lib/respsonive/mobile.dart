import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jochat/components/chatcomponent.dart';
import 'package:jochat/components/chatpagedrawer.dart';
import 'package:jochat/components/usernameform.dart';
import 'package:jochat/utils/settings.dart';
import 'package:jochat/utils/utils.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  final Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
      .collection('messages')
      .orderBy('sorting', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: primarybgcolor,
      drawer: const ChatPageDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: secondarycolor,
        ),
        centerTitle: true,
        title: const Text("joChat", style: TextStyle(color: secondarycolor)),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => const UsernameForm(),
                );
              },
              icon: const Icon(Icons.person_outline)),
        ],
      ),
      body: user.displayName == null
          ? const UsernameForm()
          : Column(
              children: [
                const Expanded(child: ChatWidget()),
                MessageBar(
                  sendButtonColor: primarycolor,
                  onSend: (message) => Utils.sendMessage(
                    user,
                    message.trim(),
                  ),
                ),
              ],
            ),
    );
  }
}
