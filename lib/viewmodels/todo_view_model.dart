import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/database_service.dart';

class ToDoViewModel extends ChangeNotifier {
  final DatabaseService _databaseService;
  List<ToDo> _todos = [];
  var _isLoading = true;

  List<ToDo> get todos => _todos;

  bool getIsLoading() {
    return _isLoading;
  }

  ToDoViewModel(this._databaseService) {
    loadTodos(); // Carregar tarefas ao inicializar
  }

  Future<List<ToDo>> loadTodos() async {
    _todos = await _databaseService.fetchTarefas();
    _isLoading = false;
    notifyListeners();
    
    return _todos;
  }

  Future<void> addTodo(ToDo todo) async {
    await _databaseService.addTodo(todo);
    loadTodos(); // Recarrega após adicionar
  }

  Future<void> toggleTodoStatus(ToDo todo) async {
    todo.done = !todo.done;
    await _databaseService.updateTodo(todo);
    notifyListeners(); // Atualiza a UI diretamente
  }

  Future<void> deleteTodo(int id) async {
    await _databaseService.deleteTodo(id);
    loadTodos(); // Recarrega após exclusão
  }
}
