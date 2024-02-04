import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Status { newTasks, onGoing, finished, canceled }

enum Category { business, personal, health, goal }

const statusIcons = {
  Status.newTasks: Icons.fiber_new,
  Status.onGoing: Icons.sync,
  Status.finished: Icons.done_all,
  Status.canceled: Icons.block
};

const categoryIcons = {
  Category.business: Icons.business_center_outlined,
  Category.goal: Icons.flag_outlined,
  Category.health: Icons.favorite_outline,
  Category.personal: Icons.person_outline
};
const statusColors = {
  Status.newTasks: Color.fromARGB(255, 170, 110, 194),
  Status.onGoing: Color.fromARGB(255, 88, 183, 185),
  Status.finished: Color.fromARGB(255, 67, 118, 199),
  Status.canceled: Color.fromARGB(255, 206, 100, 132)
};

class Task {
  Task(
      {required this.taskDescription,
      required this.date,
      required this.status,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String taskDescription;
  final DateTime date;
  final Status status;
  final Category category;
  String get formattedDate {
    return formatter.format(date);
  }
}
