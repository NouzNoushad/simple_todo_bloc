import 'package:flutter_todo_app/models/todo_model.dart';

enum TodoType {all, active, completed}

List<Todo> todoList = [
  Todo(id: 1, title: 'Eat Food', completed: false),
  Todo(id: 2, title: 'Play Games', completed: false),
  Todo(id: 3, title: 'Read Books', completed: false),
  Todo(id: 4, title: 'Watch Movies', completed: false),
];
