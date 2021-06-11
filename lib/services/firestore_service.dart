import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journal_todo/models/entry_model.dart';
import 'package:journal_todo/models/task_model.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  //get entries
  Stream<List<Entry>> getEntries() {
    return _db.collection('entries').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Entry.fromJson(doc.data())).toList());
  }

  //upsert journal
  Future<void> setEntry(Entry entry) {
    var options = SetOptions(merge: true);

    return _db
        .collection('entries')
        .doc(entry.entryID)
        .set(entry.toMap(), options);
  }

  //delete journal
  Future<void> removeEntry(String entryID) {
    return _db.collection('entries').doc(entryID).delete();
  }

  //get tasks
  Stream<List<Task>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList());
  }

  //upsert task
  Future<void> setTask(Task task) {
    var options = SetOptions(merge: true);

    return _db.collection('tasks').doc(task.taskID).set(task.toMap(), options);
  }

  //delete task
  Future<void> removeTask(String taskID) {
    return _db.collection('tasks').doc(taskID).delete();
  }

  // Future<void> countDocuments() async {
  //   QuerySnapshot _myDoc = await _db.collection('tasks').get();
  //   List<DocumentSnapshot> _myDocCount = _myDoc.docs;
  //   return _myDocCount.length;
  //   //print(_myDocCount.length); // Count of Documents in Collection
  // }
}
