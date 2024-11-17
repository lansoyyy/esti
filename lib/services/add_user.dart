import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esti/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, email, number) async {
  final docUser = FirebaseFirestore.instance.collection('Users').doc(userId);

  final json = {
    'name': name,
    'number': number,
    'email': email,
    'id': docUser.id,
    'isVerified': false,
    'favs': [],
    'profile': '',
  };

  await docUser.set(json);
}
