import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool complete;

  const Todo({
    required this.title,
    required this.complete,
    required this.id,
  });

  Todo copyWith({String? id, String? title, bool? complete}) {
    return Todo(
      id: id ?? this.id,
      complete: complete ?? this.complete,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [id, title, complete];
}
