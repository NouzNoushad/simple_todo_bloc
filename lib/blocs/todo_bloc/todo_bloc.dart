import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';
import '../../utils/constants.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoGetEvent>(getTodoList);
    on<TodoAddEvent>(addTodo);
    on<TodoCompletedEvent>(todoCompleted);
  }

  FutureOr<void> getTodoList(TodoGetEvent event, Emitter<TodoState> emit) {
    emit(TodoLoadingState());
    try {
      emit(TodoLoadedState(todoList));
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> addTodo(TodoAddEvent event, Emitter<TodoState> emit) {
    try {
      var state = this.state;
      if (state is TodoLoadedState) {
        List<Todo> newTodoList = [...state.todoList, event.todo];
        emit(TodoLoadedState(newTodoList));
      }
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }

  FutureOr<void> todoCompleted(
      TodoCompletedEvent event, Emitter<TodoState> emit) {
    try {
      var state = this.state;
      if (state is TodoLoadedState) {
        List<Todo?> completedTodo = state.todoList.map((todo) {
          if (todo.id == event.id) {
            return Todo(
                id: event.id, title: todo.title, completed: event.complete);
          }
          return todo;
        }).toList();
        print('////// todo: $completedTodo');
        emit(TodoLoadedState(completedTodo as List<Todo>));
      }
    } catch (error) {
      emit(TodoErrorState(error.toString()));
    }
  }
}
