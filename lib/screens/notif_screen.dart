import 'package:esti/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NotifScreen extends StatelessWidget {
  const NotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: TextWidget(
          text: 'Notifications',
          fontSize: 18,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber[700],
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(
                Icons.notifications_active,
                color: Colors.red,
              ),
              title: TextWidget(
                text: 'ESTI has responded to your question!',
                fontSize: 18,
                fontFamily: 'Bold',
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
