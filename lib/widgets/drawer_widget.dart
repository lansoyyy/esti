import 'package:esti/screens/feedback_screen.dart';
import 'package:esti/screens/home_screen.dart';
import 'package:esti/screens/notif_screen.dart';
import 'package:esti/tabs/sti_tab.dart';
import 'package:esti/widgets/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:esti/widgets/text_widget.dart';

import '../utils/colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 250,
      color: Colors.white,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => const FeedbackScreen()),
                );
              },
              leading: const Icon(
                Icons.feed,
              ),
              title: TextWidget(
                text: 'Feedback',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutSTIPage()),
                );
              },
              leading: Image.asset(
                'assets/images/sti.png',
                height: 35,
              ),
              title: TextWidget(
                text: 'About STI',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'ESTI',
                  applicationVersion: 'v1.0.0',
                );
              },
              leading: const Icon(
                Icons.info_outline,
              ),
              title: TextWidget(
                text: 'About ESTI',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NotifScreen()),
                );
              },
              leading: const Icon(
                Icons.notifications_none_outlined,
              ),
              title: TextWidget(
                text: 'Notifications',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            ),
            // ListTile(
            //   onTap: () {
            //     logout(context, const HomeScreen());
            //   },
            //   leading: const Icon(
            //     Icons.logout,
            //   ),
            //   title: TextWidget(
            //     text: 'Logout',
            //     fontSize: 18,
            //     fontFamily: 'Bold',
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}
