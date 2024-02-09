import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book_web_app/screens/login_page.dart';
import 'package:diary_book_web_app/util/cach_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBPxR-ocLV3NkytDx3qYAnN-0_sy8oFAQE',
          appId: '1:476480427256:web:95bd7c54b878722740170d',
          messagingSenderId: '476480427256',
          projectId: 'diarybookapp'));
  CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diary Book',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.green,
      ),
      home: const LoginPage(),
    );
  }
}

class GetInfo extends StatelessWidget {
  const GetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('diaries').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('something went wronge'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return ListTile(
                      title: Text(document.get('display_name')),
                      subtitle: Text(document.get('profession')));
                }).toList(),
              );
            }
          }),
    );
  }
}
