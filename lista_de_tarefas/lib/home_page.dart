import 'package:flutter/material.dart';
import 'models/item.dart';

class HomePage extends StatefulWidget {
  List<Item> item = <Item>[];
  // HomePage() é um nome reservado do Flutter ?
  // O HomePage() é um método construtor da pagina, para quando os intems forem
  //chamados eles apareçam na tela.
  HomePage() {
    item = [];
    item.add(Item(tarefa: "Compras", done: false));
    item.add(Item(tarefa: "Malhar", done: true));
    item.add(Item(tarefa: "Compras", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appBar = AppBar(
    title: Text(
      'To Do List',
    ),
  );

  var controleDeTsrefa = TextEditingController();

  void add() {
    if (controleDeTsrefa.text.isEmpty) {
      return;
    }
    setState(() {
      widget.item.add(
        Item(tarefa: controleDeTsrefa.text, done: false),
      );
      controleDeTsrefa.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      // ListView.bilder() cria uma matriz rolavel na tela criada sob demanda, não tendo uma lista fixa reinderizada,
      //E para controlar, ele vai precisar do itemCount e o itemBuilder .
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controleDeTsrefa,
                  keyboardType: TextInputType.text,
                  decoration:
                      InputDecoration(labelText: 'Adicionar Nova Tarefa: '),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                color: Colors.blueGrey,
                // ListView.bilder() cria uma matriz rolavel na tela criada sob demanda.
                child: SafeArea(
                  child: ListView.builder(
                    // para acessar variaveis e métodos da classe pai no caso aqui class homePage, utiliza o 'widget.'
                    itemCount: widget.item.length,
                    //o itemBuilder pergunta como construir os widgets na tela.
                    itemBuilder: (BuildContext ctxt, int index) {
                      // É criado uma variavel para poder utilizar o widget.item[index] em varios lugares
                      final item = widget.item[index];
                      return CheckboxListTile(
                        title: Text(item.tarefa),
                        value: item.done,
                        onChanged: (value) {
                          setState(() {
                            item.done = value!;
                          });
                        },
                        //O CheckboxListTile precisa de key que deve ser um item unico
                        key: Key(item.tarefa),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
