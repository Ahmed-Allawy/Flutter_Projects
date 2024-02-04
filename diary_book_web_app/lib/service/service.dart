import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user.dart';

class DiaryBookService {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.toString();
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createNewUser(
      String email, String password, String name) async {
    try {
      // create user
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // save user data
      await saveUser(userCredential.user!.uid.toString(), name);
      // login user
      return login(email, password);
    } on FirebaseAuthException catch (e) {
      return e.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> saveUser(String uid, name) async {
    UserM user = UserM(
        name: name,
        image:
            'https://th.bing.com/th/id/OIP.1EWHriZ_p9_4qefYN3_t3gHaFP?rs=1&pid=ImgDetMain',
        profession: '',
        quote: '',
        uid: uid);
    FirebaseFirestore.instance.collection('users').add(user.toMap());
    return '1';
  }

  Future<void> updateUser(UserM currUser, String name, String imageUrl) async {
    UserM newUserData = UserM(
        name: name,
        image: imageUrl,
        uid: currUser.uid,
        profession: currUser.profession,
        quote: currUser.quote);
    await userCollection.doc(currUser.id).update(newUserData.toMap());
    return;
  }
}
