import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book_web_app/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../util/cach_helper.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('something went wronge'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // get users from firestore
            final userListStream = snapshot.data!.docs.map((docs) {
              return UserM.fromDocument(docs);
            }).where((user) {
              // return data of our user (logged user)
              return user.uid == FirebaseAuth.instance.currentUser!.uid;
            }).toList();
            UserM user = userListStream[0];
            CacheHelper.saveData(key: 'userName', value: user.name);
            return Profile(user: user);
          }
        });
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
    required this.user,
  });

  final UserM user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.image!),
            ),
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return ProfileDialog(user: user);
              },
            ),
          ),
          Text(
            user.name!,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({
    super.key,
    required this.user,
  });

  final UserM user;

  @override
  Widget build(BuildContext context) {
    final imageUrlController = TextEditingController(text: user.image);
    final nameController = TextEditingController(text: user.name);
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.15,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Editing ${user.name} profile',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(166, 0, 0, 0)),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: imageUrlController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  UserService().updateUser(user, nameController.value.text,
                      imageUrlController.value.text);
                },
                style: TextButton.styleFrom(
                    elevation: 4,
                    padding: const EdgeInsets.all(10.0),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontSize: 19)),
                child: const Text('Update')),
          ],
        ),
      ),
    );
  }
}
