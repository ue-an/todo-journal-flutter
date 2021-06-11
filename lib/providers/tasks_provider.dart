import 'package:flutter/material.dart';
import 'package:journal_todo/models/task_model.dart';
import 'package:journal_todo/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class TEntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _title;
  String _content;
  String _taskID;
  var uuid = Uuid();

  //getters
  //DateTime get date => _date;
  String get title => _title;
  String get content => _content;
  Stream<List<Task>> get tasks => firestoreService.getTasks();

  //setters
  // set changeDate(DateTime date) {
  //   _date = date;
  //   notifyListeners();
  // }

  set changeTaskTitle(String title) {
    _title = title;
    notifyListeners();
  }

  set changeTaskContent(String content) {
    _content = content;
    notifyListeners();
  }

  //functions
  loadAll(Task task) {
    if (task != null) {
      _title = task.title;
      _content = task.content;
      _taskID = task.taskID;
    } else {
      _title = null;
      _content = null;
      _taskID = null;
    }
  }

  saveTask() {
    if (_taskID == null) {
      //add
      var newTask = Task(title: _title, content: _content, taskID: uuid.v1());
      firestoreService.setTask(newTask);
    } else {
      //edit
      var updatedTask = Task(title: _title, content: _content, taskID: _taskID);
      firestoreService.setTask(updatedTask);
    }
  }

  removeTask(String taskID) {
    firestoreService.removeTask(taskID);
  }

  // showTotalTasks() {
  //   firestoreService.countDocuments();
  // }
}
