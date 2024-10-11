import 'package:atividade_lista_banco/model/db_banco.dart';

class TarefasController {
  final Bd _bd = Bd.instance;

  
  // Criar uma nova tarefa
  Future<void> criarTarefa(String nome, String descricao) async {
    try {
      await _bd.criarTafera(nome, descricao);
    } catch (e) {
      print("Erro ao criar tarefa: $e");
    }
  }

  // Obter todas as tarefas
  Future<List<Map<String, dynamic>>> obterTarefas() async {
    try {
      return await _bd.getTarefa();
    } catch (e) {
      print("Erro ao obter tarefas: $e");
      return [];
    }
  }

  // Atualizar uma tarefa existente
  Future<void> atualizarTarefa(int id, String nome, String descricao) async {
    try {
      await _bd.updateTarefa(id, nome, descricao);
    } catch (e) {
      print("Erro ao atualizar tarefa: $e");
    }
  }

  // Deletar uma tarefa
  Future<void> deletarTarefa(int id) async {
    try {
      await _bd.deleteTarefa(id);
    } catch (e) {
      print("Erro ao deletar tarefa: $e");
    }
  }
}