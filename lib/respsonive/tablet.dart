import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jochat/components/chatcomponent.dart';
import 'package:jochat/components/chatpagedrawer.dart';
import 'package:jochat/components/usernameform.dart';
import 'package:jochat/utils/settings.dart';
import 'package:jochat/utils/utils.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({Key? key}) : super(key: key);

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
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
