import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

class HomePage extends StatefulWidget {
  List<Item> item = <Item>[];
  // HomePage() é um nome reservado do Flutter ?
  // O HomePage() é um método construtor da pagina, para quando os intems forem
  //chamados, eles apareçam na tela.
  HomePage() {
    item = [];
    // item.add(Item(tarefa: "Compras", done: false));
    // item.add(Item(tarefa: "Malhar", done: true));
    // item.add(Item(tarefa: "Compras", done: false));
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

  var controleDeTarefa = TextEditingController();

  void add() {
    if (controleDeTarefa.text.isEmpty) {
      return;
    }
    setState(() {
      widget.item.add(
        Item(tarefa: controleDeTarefa.text, done: false),
      );
      controleDeTarefa.clear();
      save();
    });
  }

  // Para remover o item da lista é criado uma função remover() chamando o item e a propriedade .remiveAt()
  void remover(int index) {
    setState(() {
      widget.item.removeAt(index);
      save();
    });
  }

  // é criado uma função() assincrona por que ela não ocorre em tempo real, por isto usa o async{}
  // Ele vai aguardar até que o SharedPreferences.getInstance() seja carregado.
  // A documentação mostra como usar a API e como usar a shered pefeence com o await.
  Future carregar() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> resultado = decoded.map((e) => Item.fromJason(e)).toList();
      setState(() {
        widget.item = resultado;
      });
    }
  }

  //Chamado o contrutor da HomePageState() e para chamar o método load() dentro dele (por que ??)
  _HomePageState() {
    carregar();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.item));
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
            padding: EdgeInsets.all(12),
            child: Container(
              color: Colors.blue.shade300,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: controleDeTarefa,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Adicionar Nova Tarefa:',
                    helperStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                color: Colors.white,
                // ListView.bilder() cria uma matriz rolavel na tela criada sob demanda.
                child: SafeArea(
                  child: ListView.builder(
                    // para acessar variaveis e métodos da classe pai no caso class homePage, utiliza o 'widget.'
                    itemCount: widget.item.length,
                    //o itemBuilder pergunta como construir os widgets na tela.
                    itemBuilder: (BuildContext ctxt, int index) {
                      // É criado uma variavel para poder utilizar o widget.item[index] em varios lugares
                      final item = widget.item[index];
                      // foi adicionado o widget Dismissible() = dispensavel, para remover o item deslisando.
                      return Dismissible(
                        child: CheckboxListTile(
                          title: Text(item.tarefa),
                          value: item.done,
                          onChanged: (value) {
                            setState(() {
                              item.done = value!;
                              save();
                            });
                          },
                          //O CheckboxListTile precisa de key que deve ser um item unico
                          //Mas como o Dismissible() tambem precisa foi colocado a key
                          //fora do CheckboxListTile() porque não pecisa ficar nos dois.
                        ),
                        key: Key(item.tarefa),
                        background: Container(
                          color: Colors.red.withOpacity(0.2),
                        ),
                        onDismissed: (direction) {
                          remover(index);
                        },
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
