class Item {
  late String tarefa;
  late bool done;

  Item({required this.tarefa, required this.done});
  // Json é um padão para troca e armazenamento de informaçãoes
  // todo json começa e termina com um {} e seus dados são representados em pares
  Item.fromJason(Map<String, dynamic> json) {
    tarefa = json['tarefa'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tarefa'] = this.tarefa;
    data['done'] = this.done;
    return data;
  }
}
