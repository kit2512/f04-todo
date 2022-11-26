import 'package:demo_bloc/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'bloc/todo_bloc.dart';

void main() => runApp(
      BlocProvider(
        create: (context) => TodoBloc(),
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  static int count = 0;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Todo App'),
              actions: [
                IconButton(
                    onPressed: () {
                      final newTodo = Todo(
                          id: const Uuid().v4(),
                          title: "Task ${count++}",
                          complete: false);
                      context.read<TodoBloc>().add(
                            AddTodoEvent(
                              todo: newTodo,
                            ),
                          );
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            body: state is TodoLoading
                ? const Center(
                    child: Text("Loading todos..."),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final Todo todo = state.todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        trailing: Checkbox(
                          value: todo.complete,
                          onChanged: (value) {
                            if (value != null) {
                              final Todo newTodo = todo.copyWith(
                                id: todo.id,
                                title: todo.title,
                                complete: value,
                              );
                              context.read<TodoBloc>().add(
                                    UpdateTodoEvent(todo: newTodo),
                                  );
                            }
                          },
                        ),
                      );
                    },
                    itemCount: state.todos.length,
                  ),
          );
        },
      ),
    );
  }
}
