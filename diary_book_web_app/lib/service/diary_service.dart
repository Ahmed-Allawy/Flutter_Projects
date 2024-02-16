import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book_web_app/model/diary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DiaryService {
  CollectionReference diaryCollection =
      FirebaseFirestore.instance.collection('diarys');

  Future<String> saveDiary(String title, String thoughts, String photoUrl,
      DateTime date, String name) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DiaryM diary = DiaryM(
        userId: uid,
        title: title,
        author: name,
        entryPoint: Timestamp.fromDate(date),
        photoUrl: photoUrl,
        entry: thoughts);
    diaryCollection.add(diary.toMap());
    return '1';
  }

  Future<String> storeImage(Uint8List imagefile) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    firebase_storage.FirebaseStorage fs =
        firebase_storage.FirebaseStorage.instance;
    final dateTime = DateTime.now();
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
            contentType: 'image/jpeg',
            customMetadata: {'picked_file_path': '$dateTime'});
    return fs
        .ref()
        .child('images/$dateTime/$uid')
        .putData(imagefile, metadata)
        .then((value) {
      return value.ref.getDownloadURL().then((value) {
        return value.toString();
      });
    });
  }

  Future<void> deleteDiary(String diaryID) async {
    diaryCollection.doc(diaryID).delete();
  }
}
