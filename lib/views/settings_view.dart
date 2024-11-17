import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/todo_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<ToDoViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Enable Dark Theme'),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                // Trocar tema (precisa de ThemeProvider implementado)
                // Aqui seria necessário usar um ThemeProvider ou lógica adicional para alterar o tema.
              },
            ),
            Divider(),
            ListTile(
              title: Text('Clear Completed Tasks'),
              trailing: Icon(Icons.delete),
              onTap: () {
                // Ação para limpar tarefas concluídas
                todoViewModel.todos
                    .where((todo) => todo.done)
                    .toList()
                    .forEach((todo) => todoViewModel.deleteTodo(todo.id!));

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Completed tasks cleared')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
