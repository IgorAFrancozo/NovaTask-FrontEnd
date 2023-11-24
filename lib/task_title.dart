import 'package:flutter/material.dart';

import 'models/tarefa_data.dart';
import 'models/task.dart';

class TaskTitle extends StatelessWidget {
  final Task task;
  final TasksData tasksData;

  const TaskTitle({Key? key, required this.task, required this.tasksData})
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
            if (task.done && task.tempoDecorrido != null) // Verifica se é diferente de null
              Text(
                'Tempo Decorrido: ${task.tempoDecorrido}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            if (task.done && task.tempoDecorrido == null)
              Text(
                'Tempo Decorrido: Não disponível',
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
