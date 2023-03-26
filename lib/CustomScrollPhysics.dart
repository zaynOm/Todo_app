import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';

late TodosPodo _todosPodo; // Users object to store users from json

// A function that converts a response body into a UsersPodo
TodosPodo parseJson(String responseBody) {
  final parsed = json.decode(responseBody);
  return TodosPodo.fromJson(parsed);
}

// PODO Object class for the JSON mapping
class TodosPodo {
  late List<Todo> todos;

  TodosPodo({required this.todos});

  TodosPodo.fromJson(Map<String, dynamic> json) {
    if (json['todos'] != null) {
      todos = <Todo>[];
      json['todos'].forEach((v) {
        todos.add(Todo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['todos'] = todos.map((v) => v.toJson()).toList();
    return data;
  }
}

class Todo {
  late int id;
  late String content;
  late bool isDone;

  Todo({required this.id, required this.content, this.isDone = false});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['isDone'] = isDone;
    return data;
  }
}
