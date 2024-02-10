import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todoapp/color.dart';
import 'package:todoapp/todo.dart';
import 'package:todoapp/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundTodo = [];

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            "All ToDos",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (ToDo todoo in todoList)
                          ToDoItem(
                              todo: todoo,
                              onTodoChanged: _handelToDoChange,
                              onDeleteChanged: _deleteTodoitem),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ]),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a new todo item",
                      ),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: tdBlue, elevation: 10),
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      onPressed: () {
                        _addtodoitem(_todoController.text);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void _runFilter(){



  }

  void _handelToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoitem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  Void? _addtodoitem(String toDo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo));
    });
    _todoController.clear();
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 20,
            ),
            border: InputBorder.none,
            hintText: " Search",
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),
            Container(
              width: 45,
              height: 45,
              child: ClipRRect(
                child: Image.asset("assets/avatar1.png"),
              ),
            )
          ],
        ));
  }
}
