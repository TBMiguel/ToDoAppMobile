import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/viewmodels/todo_view_model.dart';
void main() {
  setUpAll(() {
    // Inicializa o databaseFactory para sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('ToDoViewModel fetches todos correctly', () async {
    final mockDatabaseService = DatabaseService();
    await mockDatabaseService.initDatabase(); // Certifique-se de chamar o método de inicialização do banco

    // Cria a ViewModel com o mockDatabaseService
    final viewModel = ToDoViewModel(mockDatabaseService);

    await viewModel.addTodo(ToDo(title: 'TESTE', description: 'tetse'));

    // Executa o método de carregamento
    await viewModel.loadTodos();

    // Verifica se os todos foram carregados
    expect(viewModel.todos.isNotEmpty, true);
  });
}
