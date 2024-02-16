import 'package:flutter/material.dart';

import '../service/diary_service.dart';

class DeleteEntryDialog extends StatelessWidget {
  const DeleteEntryDialog({
    super.key,
    required this.diaryID,
  });

  final String diaryID;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Delete entry?',
        style: TextStyle(color: Colors.red),
      ),
      content: const Text('Are you sure you want to delete this entry?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.green),
            )),
        TextButton(
            onPressed: () => DiaryService()
                .deleteDiary(diaryID)
                .then((value) => Navigator.of(context).pop()),
            child: const Text('Delete',
                style: TextStyle(color: Colors.redAccent))),
      ],
    );
  }
}
