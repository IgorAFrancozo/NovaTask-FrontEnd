import 'package:flutter/material.dart';

import 'models/tarefa_data.dart';
import 'models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final TasksData tasksData;

  const TaskTile({Key? key, required this.task, required this.tasksData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checkbox) {
            tasksData.updateTask(task);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                decoration:
                task.done ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            if (task.done)
              Text(
                'Tempo Decorrido: ${task.tempoDecorrido}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            tasksData.deleteTask(task);
          },
        ),
      ),
    );
  }
}
