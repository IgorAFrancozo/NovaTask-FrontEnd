import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tarefa_data.dart';
import '../models/task.dart';
import '../services/database_service.dart';
import '../task_title.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NovaTask (${Provider.of<TasksData>(context).tasks.length})',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<List<Task>>(
        stream: DatabaseServices.streamTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar tarefas: ${snapshot.error}'),
            );
          } else {
            List<Task> tasks = snapshot.data!;
            Provider.of<TasksData>(context, listen: false).tasks = tasks;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<TasksData>(
                builder: (context, tasksData, child) {
                  return ListView.builder(
                    itemCount: tasksData.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasksData.tasks[index];
                      return TaskTile(
                        task: task,
                        tasksData: tasksData,
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddTaskScreen();
            },
          );
        },
      ),
    );
  }
}