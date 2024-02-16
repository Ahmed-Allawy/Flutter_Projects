import 'package:flutter/material.dart';

import '../model/diary.dart';
import '../util/utils.dart';
import 'delete_entry_dialog.dart';

class ShowEntryDialog extends StatelessWidget {
  const ShowEntryDialog({
    super.key,
    required this.diary,
  });

  final DiaryM diary;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Row(
              children: [
                Text(
                  formatDateFromTimestamp(diary.entryPoint!),
                  style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) =>
                              DeleteEntryDialog(diaryID: diary.id!));
                    },
                    icon: const Icon(Icons.delete_forever)),
              ],
            ),
          )
        ],
      ),
      content: ListTile(
        subtitle: Column(
          children: [
            Row(
              children: [
                Text(
                  '• ${formatDateFromTimestampHour(diary.entryPoint!)}',
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
            SizedBox(
                width: 500,
                height: 450,
                child: Image.network(
                  (diary.photoUrl == null || diary.photoUrl!.isEmpty)
                      ? 'https://th.bing.com/th/id/OIP.mbFQvdrQ4NeIJFp-6rNE9QHaEq?rs=1&pid=ImgDetMain'
                      : diary.photoUrl!,
                  fit: BoxFit.fill,
                )),
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          diary.title!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(diary.entry!)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.green),
            )),
      ],
    );
  }
}
