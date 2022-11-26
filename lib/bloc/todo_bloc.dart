import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_bloc/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<Todo> _demoDataTodos = <Todo>[
    Todo(
      id: const Uuid().v4(),
      title: "Task 1",
      complete: true,
    ),
    // Todo(
    //   id: const Uuid().v4(),
    //   title: "Task 2",
    //   complete: true,
    // ),
    // Todo(
    //   id: const Uuid().v4(),
    //   title: "Task 3",
    //   complete: false,
    // ),
  ];

  TodoBloc() : super(TodoLoading()) {
    _getTodos();
    on<TodoEvent>((event, emit) {});

    on<AddTodoEvent>(_addTodo);

    on<UpdateTodoEvent>(_updateTodo);
  }

  Future<void> _getTodos() async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        emit(
          TodoState(todos: _demoDataTodos),
        );
      },
    );
  }

  FutureOr<void> _addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    _demoDataTodos.add(event.todo);
    emit(TodoState(todos: _demoDataTodos));
  }

  FutureOr<void> _updateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) {
    final newTodo = event.todo;
    final index =
        _demoDataTodos.indexWhere((element) => element.id == newTodo.id);
    _demoDataTodos[index] = newTodo;
    emit(TodoState(todos: _demoDataTodos));
  }
}
