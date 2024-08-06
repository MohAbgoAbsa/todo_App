import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollectionref = getTaskCollection();
    DocumentReference<Task> taskDocRef = taskCollectionref.doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskToFireStore(Task task) {
    return getTaskCollection().doc(task.id).delete();
  }

  static Future<void> updateDoneTaskToFireStore(Task task) {
    return getTaskCollection().doc(task.id).update({'isDone': true});
  }

  static Future<void> updateAllTaskToFireStore(Task task) {
    return getTaskCollection().doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'datetime': task.datetime.millisecondsSinceEpoch,
    });
  }
}
