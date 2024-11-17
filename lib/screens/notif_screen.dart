import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esti/utils/const.dart';
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(userId)
              .where('sender', isEqualTo: 'bot')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return Expanded(
              child: ListView.builder(
                itemCount: data.docs.length,
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
            );
          }),
    );
  }
}
