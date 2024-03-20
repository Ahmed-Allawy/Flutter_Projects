import 'package:flutter/material.dart';

handlerDialog(BuildContext context, String title, String content, Color color) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              title,
              // ignore: prefer_const_constructors
              style: TextStyle(color: color),
            ),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.green),
                  )),
            ],
          ));
}
