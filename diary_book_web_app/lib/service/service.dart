import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryBookService {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> login(String email, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
