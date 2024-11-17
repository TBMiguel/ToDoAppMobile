import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  DatabaseService._internal();
  factory DatabaseService() => _instance;

  Database? _database;

  Future<Database> get database async {
    return _database ??=
        await initDatabase(); //verifica se database não é nulo, se é ele retorna database
  } //recuperar database

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'todo_app.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, done INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<ToDo>> fetchTarefas() async {
    final db = await database;
    final maps = await db.query('tarefas');
    return List.generate(
      maps.length,
      (i) => ToDo.fromMap(maps[i]),
    );
  }

  Future<int> addTodo(ToDo todo) async {
    final db = await database;
    return await db.insert('tarefas', todo.toMap());
  }

  Future<int> deleteTodo(int id) async {
    final db = await database;
    return await db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTodo(ToDo todo) async {
    final db = await database;
    return await db.update('tarefas', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
