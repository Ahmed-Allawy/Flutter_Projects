import 'package:diary_book_web_app/screens/welcome_page.dart';
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
          projectId: 'diarybookapp',
          storageBucket: 'diarybookapp.appspot.com'));
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
      home: const WelcomePage(),
    );
  }
}
