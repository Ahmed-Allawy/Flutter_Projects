import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widgets/diary_list_view.dart';
import '../widgets/user_profile.dart';
import '../widgets/write_diary_dialog.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _dropMenuText;
  DateTime currentDate = DateTime.now();
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 100,
        elevation: 70,
        shadowColor: const Color.fromARGB(94, 255, 255, 255),
        title: Row(
          children: [
            Text(
              'Diary',
              style: TextStyle(fontSize: 39, color: Colors.blueGrey.shade400),
            ),
            const Text(
              'Book',
              style: TextStyle(fontSize: 39, color: Colors.green),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              items: <String>['Latest', 'Earliest'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _dropMenuText = value;
                });
              },
              hint: _dropMenuText == null
                  ? const Text('Filter')
                  : Text(_dropMenuText!),
            ),
          ),
          const UserProfile(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.logout_outlined,
              ),
              color: Colors.redAccent,
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                });
              },
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.rectangle,
                    border: const Border(
                        right: BorderSide(width: 0.4, color: Colors.blueGrey))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: SfDateRangePicker(
                        onSelectionChanged: (dateRangePickerSelection) {
                          setState(() {
                            date = dateRangePickerSelection.value;
                            date = date.add(Duration(
                                hours: currentDate.hour,
                                minutes: currentDate.minute,
                                seconds: currentDate.second,
                                milliseconds: currentDate.millisecond));
                          });
                        },
                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: TextButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return WriteDiaryDialog(
                                  date: date,
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.greenAccent,
                          ),
                          label: const Text(
                            'Write New',
                            style: TextStyle(color: Colors.green),
                          )),
                    ),
                  ],
                ),
              )),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  DiaryListView(
                    date: date,
                    latest: _dropMenuText == 'Latest' ? true : false,
                  ),
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return WriteDiaryDialog(
                date: date,
              );
            },
          );
        },
        tooltip: 'Add',
        shape: const CircleBorder(),
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
