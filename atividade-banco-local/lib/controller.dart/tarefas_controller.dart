import 'package:atividade_lista_banco/model/db_banco.dart';

class TarefasController {
  final Bd bd = Bd.instance;

  
  // Cria a tarefa
  Future<void> criarTarefa(String nome, String descricao) async {
      await bd.criarTafera(nome, descricao); 
  }

  // obtem as tarefas
  Future<List<Map<String, dynamic>>> obterTarefas() async {
    
      return await bd.getTarefa();
   
  }

  // Atualiza a tarefa
  Future<void> atualizarTarefa(int id, String nome, String descricao) async {
      await bd.updateTarefa(id, nome, descricao);
  }

  // Deletar a tarefa
  Future<void> deletarTarefa(int id) async {
      await bd.deleteTarefa(id);
  }
}