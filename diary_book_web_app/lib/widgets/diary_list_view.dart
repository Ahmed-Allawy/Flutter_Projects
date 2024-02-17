import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_book_web_app/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/diary.dart';
import 'delete_entry_dialog.dart';
import 'show_entry_dialog.dart';

class DiaryListView extends StatelessWidget {
  const DiaryListView({
    super.key,
    required this.date,
    this.latest = false,
  });
  final DateTime? date;
  final bool latest;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('diarys')
            .orderBy('entryPoint', descending: latest)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('something went wronge'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator());
          } else {
            // get users from firestore
            final diaryListStream = snapshot.data!.docs.map((docs) {
              return DiaryM.fromDocument(docs);
            }).where((diary) {
              // return data of our user (logged user)
              return diary.userId == FirebaseAuth.instance.currentUser!.uid &&
                  formatDateFromTimestampDay(diary.entryPoint!) ==
                      date!.day.toString();
            }).toList();
            return DiaryList(diaryListStream: diaryListStream);
          }
        });
  }
}

class DiaryList extends StatelessWidget {
  const DiaryList({
    super.key,
    required this.diaryListStream,
  });

  final List<DiaryM> diaryListStream;

  @override
  Widget build(BuildContext context) {
    return diaryListStream.isNotEmpty
        ? Expanded(
            child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ListView.builder(
              itemCount: diaryListStream.length,
              itemBuilder: (context, index) {
                DiaryM diary = diaryListStream[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: const BeveledRectangleBorder(),
                  elevation: 4.0,
                  child: InkWell(
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDateFromTimestamp(diary.entryPoint!),
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      DeleteEntryDialog(diaryID: diary.id!),
                                );
                              },
                              icon: const Icon(Icons.delete_forever))
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '• ${formatDateFromTimestampHour(diary.entryPoint!)}',
                                style: const TextStyle(color: Colors.green),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.green,
                                  ))
                            ],
                          ),
                          SizedBox(
                              width: 400,
                              height: 350,
                              child: Image.network(
                                (diary.photoUrl == null ||
                                        diary.photoUrl!.isEmpty)
                                    ? 'https://th.bing.com/th/id/OIP.mbFQvdrQ4NeIJFp-6rNE9QHaEq?rs=1&pid=ImgDetMain'
                                    : diary.photoUrl!,
                                fit: BoxFit.fill,
                              )),
                          Row(
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      diary.title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(diary.entry!),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => ShowEntryDialog(diary: diary),
                      );
                    },
                  ),
                );
              },
            ),
          ))
        : Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.15,
              child: const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No diaries at this date',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  )
                ],
              )),
            ),
          );
  }
}
