import 'package:flutter/material.dart';
import 'package:journal_todo/models/entry_model.dart';
import 'package:journal_todo/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class JEntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  DateTime _date;
  String _entry;
  String _entryID;
  var uuid = Uuid();

  //getters
  DateTime get date => _date;
  String get entry => _entry;
  Stream<List<Entry>> get entries => firestoreService.getEntries();

  //setters
  set changeDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  set changeEntry(String entry) {
    _entry = entry;
    notifyListeners();
  }

  //functions
  loadAll(Entry entry) {
    if (entry != null) {
      _date = DateTime.parse(entry.date);
      _entry = entry.entry;
      _entryID = entry.entryID;
    } else {
      _date = DateTime.now();
      _entry = null;
      _entryID = null;
    }
  }

  saveEntry() {
    if (_entryID == null) {
      //add
      var newEntry = Entry(
          date: _date.toIso8601String(), entry: _entry, entryID: uuid.v1());
      firestoreService.setEntry(newEntry);
    } else {
      //edit
      var updatedEntry = Entry(
          date: _date.toIso8601String(), entry: _entry, entryID: _entryID);
      firestoreService.setEntry(updatedEntry);
    }
  }

  removeEntry(String entryID) {
    firestoreService.removeEntry(entryID);
  }
}
