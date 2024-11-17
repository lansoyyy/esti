import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esti/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addChat(msg, sender) async {
  final docUser = FirebaseFirestore.instance
      .collection(userId)
      .doc(DateTime.now().toString());

  final json = {
    'msg': msg,
    'sender': sender,
    'id': docUser.id,
    'isSeen': false,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
}
