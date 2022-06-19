import 'package:flutter/material.dart';

import 'models/item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  List<Item> item = <Item>[];
  TodoPage() {
    item = [];
    item.add(Item(tarefa: "Compras", done: false));
    item.add(Item(tarefa: "Malhar", done: true));
    item.add(Item(tarefa: "Compras", done: false));
  }
}

class _HomePageState extends State<HomePage> {
  final appBar = AppBar(
    title: Text(
      'To Do List',
    ),
  );

  var newTaskCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      // ListView.bilder() cria uma matriz rolavel na tela criada sob demanda,
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
                  controller: newTaskCtrl,
                  keyboardType: TextInputType.text,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              // ListView.bilder() cria uma matriz rolavel na tela criada sob demanda.
              child: SafeArea(
                child: ListView.builder(
                  itemCount: widget.item.length,
                  itemBuilder: (ctxt, index) {
                    return Text(widget.item[index].tarefa);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
