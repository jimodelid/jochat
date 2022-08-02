import 'package:flutter/material.dart';
import 'package:jochat/pages/authpage.dart';
import 'package:jochat/utils/settings.dart';
import 'package:jochat/utils/utils.dart';

class ChatPageDrawer extends StatelessWidget {
  const ChatPageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: primarybgcolor,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 200,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Just a demo app for the portfolio'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Could list users, active/inactive etc.'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text(
                      'Maybe a link list to other pages within the app.'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                Utils.signOut(context).then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const AuthPage(),
                    ),
                    (Route<dynamic> route) => false,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: secondarycolor,
                padding: const EdgeInsets.all(20),
              ),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
