import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/dependency_injector.dart';
import 'views/home_view.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: DependencyInjector.providers,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}
