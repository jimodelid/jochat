import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jochat/utils/settings.dart';
import 'package:jochat/utils/utils.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> messagesStream = FirebaseFirestore.instance
        .collection('messages')
        .limit(50)
        .orderBy('sorting', descending: true)
        .snapshots();
    final ScrollController sc = ScrollController();
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: messagesStream,
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Utils.showSnackbar('${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Getting messages..'));
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('No messages yet. Lets start chatting shall we?'),
              );
            }

            return ListView(
              controller: sc,
              children:
                  snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                SchedulerBinding.instance.addPostFrameCallback(
                  (_) {
                    sc.animateTo(
                      sc.position.maxScrollExtent,
                      duration: const Duration(microseconds: 10),
                      curve: Curves.easeInOut,
                    );
                  },
                );

                return Padding(
                  padding: user.uid == data['sender']
                      ? EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                        )
                      : EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                  child: BubbleSpecialThree(
                    text: data['name'] +
                        ' - ' +
                        data['date'] +
                        '\n' +
                        data['message'],
                    color: data['sender'] == user.uid
                        ? primarycolor
                        : secondarycolor,
                    tail: true,
                    isSender: data['sender'] == user.uid ? true : false,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
