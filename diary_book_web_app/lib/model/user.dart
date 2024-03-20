import 'package:cloud_firestore/cloud_firestore.dart';

class UserM {
  String? name;
  String? image;
  String? profession;
  String? quote;
  String? uid;
  String? id;

  UserM(
      {this.name, this.image, this.profession, this.uid, this.quote, this.id});
  factory UserM.fromDocument(QueryDocumentSnapshot data) {
    return UserM(
        name: data.get('name'),
        image: data.get('image'),
        profession: data.get('profession'),
        quote: data.get('quote'),
        uid: data.get('uid'),
        id: data.id);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'profession': profession,
      'quote': quote,
      'uid': uid
    };
  }
}
