import 'package:flutter/material.dart';

Widget showLoadingDialog() {
  return const Dialog(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16.0),
          Text('Connecting...'),
        ],
      ),
    ),
  );
}
