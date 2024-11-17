import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../viewmodels/todo_view_model.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDo todo;

  const ToDoItemWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<ToDoViewModel>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            todo.done ? Icons.check_circle : Icons.circle_outlined,
            color: todo.done ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            // Alternar o status de conclusão da tarefa
            todoViewModel.toggleTodoStatus(todo);
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.done ? TextDecoration.lineThrough : null,
            color: todo.done ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text(
          todo.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Remover tarefa da lista
            todoViewModel.deleteTodo(todo.id!);
          },
        ),
      ),
    );
  }
}
