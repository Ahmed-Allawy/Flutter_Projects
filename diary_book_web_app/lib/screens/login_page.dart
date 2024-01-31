import 'package:diary_book_web_app/widgets/create_account_form.dart';
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreatedAccountClicked = false;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFB9C2D1),
            )),
        isCreatedAccountClicked ? CreateAccountForm() : LoginForm(),
        const SizedBox(
          height: 30,
        ),
        TextButton.icon(
            onPressed: () {
              setState(() {
                if (isCreatedAccountClicked) {
                  isCreatedAccountClicked = false;
                } else {
                  isCreatedAccountClicked = true;
                }
              });
            },
            icon: const Icon(
              Icons.portrait_rounded,
              color: Colors.green,
            ),
            label: Text(
              isCreatedAccountClicked
                  ? 'Already have an account?'
                  : 'Create Account',
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
            )),
        Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFFB9C2D1),
            )),
      ],
    ));
  }
}
