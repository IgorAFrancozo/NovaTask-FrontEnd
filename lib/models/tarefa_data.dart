import 'package:flutter/cupertino.dart';
import 'package:novatask/models/task.dart';

import '../services/database_service.dart';


class TasksData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String taskTitle) async {
    Task task = await DatabaseServices.addTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggle();
    DatabaseServices.updateTask(task.id);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    DatabaseServices.deleteTask(task.id);
    notifyListeners();
  }
}
