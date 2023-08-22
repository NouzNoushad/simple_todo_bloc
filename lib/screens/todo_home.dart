import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/blocs/todo_bloc/todo_bloc.dart';
import 'package:flutter_todo_app/utils/constants.dart';

import '../models/todo_model.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> with TickerProviderStateMixin {
  late TabController tabController;
  late final TextEditingController textEditingController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    textEditingController = TextEditingController();
    super.initState();
  }

  List<Todo> checkTodoState(TodoType todoType, List<Todo> todoList) {
    List<Todo> filteredTodo = switch (todoType) {
      TodoType.all => todoList,
      TodoType.active =>
        todoList.where((element) => element.completed == false).toList(),
      TodoType.completed =>
        todoList.where((element) => element.completed == true).toList(),
    };
    return filteredTodo;

    // List<Todo> filteredTodo = [];
    // if (todoType == TodoType.all) {
    //   filteredTodo = state.todoList;
    // }
    // if (todoType == TodoType.active) {
    //   filteredTodo = state.todoList
    //       .where((element) => element.completed == false)
    //       .toList();
    // }
    // if (todoType == TodoType.completed) {
    //   filteredTodo =
    //       state.todoList.where((element) => element.completed == true).toList();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(
                    color: Colors.green.shade900, decorationThickness: 0),
                onSubmitted: (value) {
                  int newId = todoList.length + 1;
                  Todo todo = Todo(
                      id: newId,
                      title: textEditingController.text,
                      completed: false);
                  context.read<TodoBloc>().add(TodoAddEvent(todo));
                  textEditingController.text = '';
                },
                decoration: InputDecoration(
                    hintText: 'What to do?',
                    hintStyle: TextStyle(color: Colors.green.shade200),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1.5, color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1.5, color: Colors.green),
                    )),
              ),
            ),
            TabBar(
                labelPadding: const EdgeInsets.all(10),
                controller: tabController,
                labelColor: Colors.green,
                indicatorColor: Colors.green,
                overlayColor: MaterialStateProperty.all(Colors.white),
                tabs: const [
                  Text(
                    'All',
                  ),
                  Text(
                    'Active',
                  ),
                  Text(
                    'Completed',
                  ),
                ]),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                todoListTabView(TodoType.all),
                todoListTabView(TodoType.active),
                todoListTabView(TodoType.completed),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget todoListTabView(TodoType todoType) => Material(
        color: Colors.green.shade100,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodoLoadedState) {
              List<Todo> filteredTodo =
                  checkTodoState(todoType, state.todoList);
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: filteredTodo.length,
                itemBuilder: (context, index) {
                  var todo = filteredTodo[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 10, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green.shade900,
                            ),
                          ),
                          Checkbox(
                              activeColor: Colors.green.shade900,
                              value: todo.completed,
                              onChanged: (value) {
                                context
                                    .read<TodoBloc>()
                                    .add(TodoCompletedEvent(todo.id, value!));
                              })
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      );
}
