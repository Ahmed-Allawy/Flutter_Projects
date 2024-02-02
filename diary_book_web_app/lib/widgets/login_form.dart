import 'package:diary_book_web_app/screens/main_page.dart';
import 'package:diary_book_web_app/service/service.dart';
import 'package:flutter/material.dart';

import 'custom_input_decorator.dart';

class LoginForm extends StatelessWidget {
  LoginForm({
    super.key,
  });

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    return SizedBox(
      width: 300,
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
                validator: (value) {
                  return value!.isEmpty ? 'plaease enter an email' : null;
                },
                controller: emailTextController,
                decoration: customInputDecoration('Email', 'Allawy@gmail.com'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'plaease enter a password' : null;
                },
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
                    if (globalKey.currentState!.validate()) {
                      DiaryBookService()
                          .login(emailTextController.value.text,
                              passwordTextController.value.text)
                          // FirebaseAuth.instance
                          //     .signInWithEmailAndPassword(
                          //         email: emailTextController.value.text,
                          //         password: passwordTextController.value.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      });
                    }
                  },
                  child: const Text('Sign In')
                  //  child: const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                  //   child: CircularProgressIndicator(
                  //     color: Colors.blueGrey,
                  //   ),
                  // )

                  ),
              const SizedBox(
                height: 15,
              ),
            ],
          )),
    );
  }
}
