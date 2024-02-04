import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_app/models/task_model.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.orgTask, required this.editTask});
  final Task orgTask;
  final Function(String id, Task newTask) editTask;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _taskController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;
  // taskController dateController categoryController
  void onEditTask() {
    var newTask = Task(
        taskDescription: _taskController.text,
        date:_selectedDate!,
        status: widget.orgTask.status,
        category: _selectedCategory!);
    widget.editTask(widget.orgTask.id, newTask);
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    var now = DateTime.now();
    var lastDate = DateTime(now.year + 1, now.day, now.month);
    var pickedDate = await showDatePicker(
        context: context,
        firstDate: now,
        lastDate: lastDate,
        initialDate: _selectedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void initState() {
    _selectedCategory = widget.orgTask.category;
    _selectedDate = widget.orgTask.date;
    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: Color.fromARGB(255, 157, 119, 234).withOpacity(0.6),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _taskController
                ..text = widget.orgTask.taskDescription,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  dropdownColor: Colors.deepPurple.shade300,
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: [
                              Icon(
                                categoryIcons[category],
                                color: Colors.white,
                              ),
                              Text(
                                category.name,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Text(
                      formatter.format(_selectedDate!),
                      style: TextStyle(
                          color: Color.fromARGB(250, 209, 208, 208),
                          fontSize: 13),
                    ),
                    IconButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        )),
                  ],
                )
              ],
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                onEditTask();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'save',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
                ),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
