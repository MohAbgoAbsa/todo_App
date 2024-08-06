import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';

class ChangeProvi extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  String selectlang = 'en';

  List<Task> taskList = [];

  DateTime selectDate = DateTime.now();

  void changlang(String oldlang) {
    if (selectlang == oldlang) {
      return;
    }
    selectlang = oldlang;
    notifyListeners();
  }

  void changmode(ThemeMode oldmode) {
    if (themeMode == oldmode) {
      return;
    }
    themeMode = oldmode;
    notifyListeners();
  }

  void getAllTaskFromFirestor() async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTaskCollection().get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filtter data with date

    taskList = taskList.where((task) {
      if (selectDate.day == task.datetime.day &&
          selectDate.month == task.datetime.month &&
          selectDate.year == task.datetime.year) {
        return true;
      }
      return false;
    }).toList();

    /// sort data with date
    taskList.sort((Task task1, Task task2) {
      return task1.datetime.compareTo(task2.datetime);
    });

    notifyListeners();
  }

  void changSelectDate(DateTime selectNewDate) {
    selectDate = selectNewDate;
    getAllTaskFromFirestor();
  }
}
