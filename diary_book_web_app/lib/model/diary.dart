import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryM {
  String? id;
  String? userId;
  String? title;
  String? author;
  Timestamp? entryPoint;
  String? photoUrl;
  String? entry;
  DiaryM(
      {this.id,
      this.userId,
      this.title,
      this.author,
      this.entryPoint,
      this.photoUrl,
      this.entry});

  factory DiaryM.fromDocument(QueryDocumentSnapshot data) {
    return DiaryM(
      id: data.id,
      userId: data.get('userId'),
      title: data.get('title'),
      author: data.get('author'),
      entryPoint: data.get('entryPoint'),
      photoUrl: data.get('photoUrl'),
      entry: data.get('entry'),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'author': author,
      'entryPoint': entryPoint,
      'photoUrl': photoUrl,
      'entry': entry,
    };
  }
}
