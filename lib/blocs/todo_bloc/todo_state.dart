part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoLoadedState extends TodoState {
  final List<Todo> todoList;
  const TodoLoadedState(this.todoList);
  @override
  List<Object> get props => [todoList];
}

final class TodoErrorState extends TodoState {
  final String error;
  const TodoErrorState(this.error);
  @override
  List<Object> get props => [error];
}
