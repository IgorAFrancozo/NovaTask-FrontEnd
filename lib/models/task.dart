class Task {
  final int id;
  final String title;
  bool done;
  final String dataCadastro;
  final String? tempoDecorrido;

  Task({
    required this.id,
    required this.title,
    required this.dataCadastro,
    required this.done,
    this.tempoDecorrido,
  });

  factory Task.fromMap(Map<String, dynamic> taskMap) {
    return Task(
      id: taskMap['id'] as int,
      title: taskMap['titulo'] as String,
      done: taskMap['feito'] as bool,
      tempoDecorrido: taskMap['tempoDecorrido'] as String?, // Use String? se pode ser nulo
      dataCadastro: taskMap['dataCadastro'] as String,
    );
  }

  void toggle() {
    done = !done;
  }
}