import 'package:diary_book_web_app/screens/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xfff5f6f8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'DiaryBook.',
              style: TextStyle(
                  fontSize: 39,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black45),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              '"Document your life"',
              style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.black26),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              )),
              icon: const Icon(Icons.login_outlined, color: Colors.green),
              label: const Text(
                'Sign in to Get Started',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
