import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/views/settings_view.dart';
import '../viewmodels/todo_view_model.dart';
import 'add_task_view.dart';
import '../widgets/todo_item_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<ToDoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsView()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: todoViewModel.loadTodos(),
          builder: (context, snapshot) =>
              todoViewModel.getIsLoading()
                  ? const Center(child: CircularProgressIndicator())
                  : Consumer<ToDoViewModel>(
                      builder: (context, model, child) {
                        if (model.todos.isEmpty) {
                          return Center(
                            child: Text(
                              'No tasks yet!',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: model.todos.length,
                          itemBuilder: (context, index) {
                            return ToDoItemWidget(todo: model.todos[index]);
                          },
                        );
                      },
                    )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskView()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
