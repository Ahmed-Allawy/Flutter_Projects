import 'package:diary_book_web_app/service/diary_service.dart';
import 'package:flutter/material.dart';

import '../util/cach_helper.dart';
import '../util/utils.dart';

class WriteDiaryDialog extends StatelessWidget {
  const WriteDiaryDialog({
    super.key,
    required this.date,
  });
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleTextController = TextEditingController();
    final TextEditingController thoughtsTextController =
        TextEditingController();
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(fontSize: 15)),
                    child: const Text('Discard')),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      if (titleTextController.toString().isNotEmpty &&
                          thoughtsTextController.toString().isNotEmpty) {
                        DiaryService()
                            .saveDiary(
                                titleTextController.value.text,
                                thoughtsTextController.value.text,
                                '',
                                date,
                                CacheHelper.getData(key: 'userName'))
                            .then((value) => Navigator.of(context).pop());
                      }
                    },
                    style: TextButton.styleFrom(
                        elevation: 4,
                        padding: const EdgeInsets.all(10.0),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                color: Colors.green, width: 1)),
                        textStyle: const TextStyle(fontSize: 15)),
                    child: const Text('Done')),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white12,
                      child: Column(
                        children: [
                          IconButton(
                              splashRadius: 26,
                              onPressed: () {},
                              icon: const Icon(Icons.image)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formatDate(date)),
                          Form(
                              child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                child: Container(
                                  width: 550,
                                  color: Colors.green,
                                  child: const Text('image show space'),
                                ),
                              ),
                              TextField(
                                controller: titleTextController,
                                decoration:
                                    const InputDecoration(hintText: 'title...'),
                              ),
                              TextField(
                                controller: thoughtsTextController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    hintText: 'Write your thoughts here...'),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
