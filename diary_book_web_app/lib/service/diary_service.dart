import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book_web_app/model/diary.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryService {
  CollectionReference diaryCollection =
      FirebaseFirestore.instance.collection('diarys');

  Future<String> saveDiary(
      String title, String thoughts, String photoUrl) async {
    DiaryM diary = DiaryM(
        userId: FirebaseAuth.instance.currentUser!.uid,
        title: title,
        author: 'allawy',
        entryPoint: Timestamp.fromDate(DateTime.now()),
        photoUrl: photoUrl,
        entry: thoughts);
    diaryCollection.add(diary.toMap());
    return '1';
  }
}
