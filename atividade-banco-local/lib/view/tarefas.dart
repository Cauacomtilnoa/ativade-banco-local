import 'package:atividade_lista_banco/controller.dart/tarefas_controller.dart';
import 'package:atividade_lista_banco/model/db_banco.dart';
import 'package:flutter/material.dart';

class Tarefas extends StatefulWidget {
  const Tarefas({super.key});

  @override
  State<Tarefas> createState() => _TarefasState();
}

class _TarefasState extends State<Tarefas> {
  final TarefasController _controller = TarefasController();
  List<Map<String, dynamic>> tarefas = [];

  @override
  void initState() {
    super.initState();
    _carregaTarefa();
  }

  // Carregar tarefas do banco de dados
  Future<void> _carregaTarefa() async {
    final tarefaList =
        await Bd.instance.getTarefa(); // Chama o método gettarefas
    setState(() {
      tarefas = tarefaList;
    });
  }

  void caixaEditar(
      BuildContext context, int id, String nome, String descricao) {
    TextEditingController nomeController = TextEditingController(text: nome);
    TextEditingController descricaoController =
        TextEditingController(text: descricao);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Tarefa'),
              ),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição da Tarefa '),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Atualizar"),
              onPressed: () {
                _controller.atualizarTarefa(
                    id, nomeController.text, descricaoController.text);
                _carregaTarefa();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void caixaAdicionar(BuildContext context) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController descricaoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Tarefa"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Tarefa'),
              ),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição da Tarefa'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Adicionar"),
              onPressed: () {
                _controller.criarTarefa(
                    nomeController.text, descricaoController.text);
                _carregaTarefa();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tarefas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: ListView.builder(
        itemCount: tarefas.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Colors.lightBlue[100],
              title: Text(
                tarefas[index]['nome'],
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text('${tarefas[index]['descricao']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => caixaEditar(
                      context,
                      tarefas[index]['id'],
                      tarefas[index]['nome'],
                      tarefas[index]['descricao'],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  Text("Você tem certeza que deseja remover ?"),
                              actions: [
                                TextButton(
                                  child: Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text("Deletar"),
                                  onPressed: () {
                                    _controller
                                        .deletarTarefa(tarefas[index]['id']);
                                    _carregaTarefa();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          })
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[100],
        onPressed: () {
          setState(() {
            caixaAdicionar(context);
          });
        },
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }
}
