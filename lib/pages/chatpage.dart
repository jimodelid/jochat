import 'package:flutter/material.dart';
import 'package:jochat/respsonive/desktop.dart';
import 'package:jochat/respsonive/layout.dart';
import 'package:jochat/respsonive/mobile.dart';
import 'package:jochat/respsonive/tablet.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    user.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const RepsonsiveLayout(
      mobileScaffold: MobileScaffold(),
      tabletScaffold: TabletScaffold(),
      desktopScaffold: DesktopScaffold(),
    );
  }
}
