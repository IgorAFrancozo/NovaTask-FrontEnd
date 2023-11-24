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
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (responseMap is Map<String, dynamic>) {
      Task task = Task.fromMap(responseMap);
      return task;
    } else {
      // Trate a situação em que o mapa não é do tipo esperado.
      throw Exception('Resposta do servidor não está no formato esperado.');
    }
  }

  static Future<List<Task>> getTasks() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List<dynamic> responseList = jsonDecode(response.body);
    if (responseList is List<dynamic>) {
      List<Task> tasks = [];
      for (Map<String, dynamic> taskMap in responseList) {
        Task task = Task.fromMap(taskMap);
        tasks.add(task);
      }
      return tasks;
    } else {
      // Trate a situação em que a lista não é do tipo esperado.
      throw Exception('Resposta do servidor não está no formato esperado.');
    }
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
