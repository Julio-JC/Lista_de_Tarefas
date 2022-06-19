class Item {
  late String tarefa;
  late bool done;

  Item({required this.tarefa, required this.done});

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
