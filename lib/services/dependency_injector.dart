import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../services/database_service.dart';
import '../viewmodels/todo_view_model.dart';

class DependencyInjector {
  static List<SingleChildWidget> providers = [
    // Provedor do DatabaseService (singleton)
    Provider<DatabaseService>(
      create: (_) => DatabaseService(),
    ),

    // Provedor do ToDoViewModel (utiliza DatabaseService)
    ChangeNotifierProvider<ToDoViewModel>(
      create: (context) => ToDoViewModel(
        context.read<DatabaseService>(),
      ),
    ),
  ];
}
