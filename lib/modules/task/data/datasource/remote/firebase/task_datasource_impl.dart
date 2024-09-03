import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/core/error/exceptions.dart';
import 'package:task_manager/modules/task/data/datasource/remote/firebase/task_datasource.dart';
import 'package:task_manager/modules/task/domain/entities/task_entity.dart';
import 'package:task_manager/modules/task/domain/usecases/add_task_usecase.dart';

class FirebaseTaskDatasourceImpl implements FirebaseTaskDatasource {
  final FirebaseFirestore firestore;

  FirebaseTaskDatasourceImpl({
    required this.firestore,
  });

  @override
  Future<void> addTask(TaskOpParams? params) async {
    try {
      final task = params?.task;

      await firestore.collection('tasks').doc(task?.id).set({
        'title': task?.title,
        'description': task?.description,
        'selectedCateories': task?.selectedCateories,
        'authorId': task?.authorId,
        'authorEmail': task?.authorEmail,
        'isCompleted': task?.isCompleted,
      });
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }

  @override
  Future<void> updateTask(TaskOpParams? params) async {
    try {
      final task = params?.task;

      await firestore.collection('tasks').doc(task?.id).update({
        'title': task?.title,
        'description': task?.description,
        'authorId': task?.authorId,
        'authorEmail': task?.authorEmail,
        'selectedCateories': task?.selectedCateories,
        'isCompleted': task?.isCompleted,
      });
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTask(String? taskId) async {
    try {
      await firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }

  @override
  Future<Stream<List<TaskEnitity?>?>?> getTasks() async {
    try {
      return firestore.collection('tasks').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return TaskEnitity(
            id: doc.id,
            title: doc['title'],
            authorId: doc['authorId'],
            authorEmail: doc['authorEmail'],
            description: doc['description'],
            selectedCateories: List<String>.from(doc['selectedCateories']),
            isCompleted: doc['isCompleted'],
          );
        }).toList();
      });
    } catch (e) {
      throw DatasourceException(message: e.toString());
    }
  }
}
