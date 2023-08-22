part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoGetEvent extends TodoEvent {
  const TodoGetEvent();

  @override
  List<Object> get props => [];
}

class TodoAddEvent extends TodoEvent {
  final Todo todo;
  const TodoAddEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoCompletedEvent extends TodoEvent {
  final bool complete;
  final int id;
  const TodoCompletedEvent(this.id, this.complete);

  @override
  List<Object> get props => [id, complete];
}
