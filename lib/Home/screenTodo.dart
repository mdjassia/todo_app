import 'package:flutter/material.dart';

import '../data/todo.dart';
import 'itemtodo.dart';

class ScreenTodo extends StatefulWidget {
  final List<Todo> list ;
  const ScreenTodo({ required this.list , super.key});

  @override
  State<ScreenTodo> createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
  @override
  Widget build(BuildContext context) {
    var list = widget.list ;
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListItem(todo: list[index]) ;
        },


    );
  }
}
