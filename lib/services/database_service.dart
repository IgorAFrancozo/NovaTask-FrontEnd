import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/task.dart';
import 'global.dart';

class DatabaseServices {
  static Stream<List<Task>> streamTasks() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield await getTasks();
    }
  }

  static Future<Task> addTask(String title) async {
    Map data = {
      "titulo": title,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseURL + '/adicionar');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Task task = Task.fromMap(responseMap);

    return task;
  }

  static Future<List<Task>> getTasks() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<http.Response> updateTask(int id) async {
    var url = Uri.parse(baseURL + '/atualizar/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    var url = Uri.parse(baseURL + '/deletar/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}
