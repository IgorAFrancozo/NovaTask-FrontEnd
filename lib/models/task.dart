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

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['titulo'],
      done: taskMap['feito'],
      tempoDecorrido: taskMap['tempo_decorrido'],
      dataCadastro: taskMap['data_cadastro'],
    );
  }

  void toggle() {
    done = !done;
  }
}
