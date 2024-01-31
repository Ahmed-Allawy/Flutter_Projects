import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_input_decorator.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.globalKey,
    required this.emailTextController,
    required this.passwordTextController,
  });

  final GlobalKey<FormState> globalKey;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Form(
          key: globalKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Sign in',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(169, 0, 0, 0)),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailTextController,
                decoration: customInputDecoration('Email', 'Allawy@gmail.com'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordTextController,
                decoration: customInputDecoration('Password', ''),
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      textStyle: const TextStyle(fontSize: 19)),
                  onPressed: () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailTextController.value.text,
                            password: passwordTextController.value.text)
                        .then((value) {
                      print(value.user!);
                    });
                  },
                  child: const Text('Sign In')
                  //  child: const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //   child: CircularProgressIndicator(
                  //     color: Colors.blueGrey,
                  //   ),
                  // )
                  )
            ],
          )),
    );
  }
}
