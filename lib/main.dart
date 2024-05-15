import 'package:flutter/material.dart';
import 'package:to_do_app/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_app/todo_bloc/to_do_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory(),);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: Colors.black,
          onBackground: Colors.white,
          primary: Colors.greenAccent,
          onPrimary: Colors.black45,
          secondary: Colors.blueAccent,
          onSecondary: Colors.white70,
        ),
      ),
      home: BlocProvider<ToDoBloc> (
        create: (context) => ToDoBloc()..add(AppStarted()),
        child: const HomeScreen(),
      )
    );
  }
}
