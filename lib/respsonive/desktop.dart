import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:jochat/components/chatcomponent.dart';
import 'package:jochat/components/chatpagedrawer.dart';
import 'package:jochat/components/usernameform.dart';
import 'package:jochat/utils/settings.dart';
import 'package:jochat/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarybgcolor,
        body: user.displayName == null
            ? const UsernameForm()
            : Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: const ChatPageDrawer(),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'joChat',
                                style: TextStyle(
                                    color: secondarycolor, fontSize: 20),
                              ),
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
                        ),
                        const Expanded(
                          child: ChatWidget(),
                        ),
                        SizedBox(
                          child: MessageBar(
                            sendButtonColor: primarycolor,
                            onSend: (message) => Utils.sendMessage(
                              user,
                              message.trim(),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
