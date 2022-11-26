part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent({
    required this.todo,
  });
}

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;
  const RemoveTodoEvent({required this.todo});
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  const UpdateTodoEvent({required this.todo});
}
