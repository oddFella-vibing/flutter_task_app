import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/data/task_list.dart';
import 'package:task_app/models/task_model.dart';
import 'package:task_app/utils/edit_task.dart';

import 'package:task_app/utils/new_task.dart';
import 'package:task_app/utils/status_item.dart';
import 'package:task_app/utils/task_graph.dart';
import 'package:task_app/utils/task_item.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({super.key});

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  List<Task> taskList = TaskList().getTaskList;
  List<Task> filteredList = [];
  Status? _chosenStatus;
  Category? _chosenCategory;

  @override
  void initState() {
    super.initState();
    filteredList = taskList;
  }

  void _onEditAlert(Task task) {
    showDialog(
      context: context,
      builder: (context) => EditTask(orgTask: task, editTask: _editTask),
    );
  }

  void _editTask(String taskID, Task newTask) {
    setState(() {
      var taskIndex = taskList.indexWhere((task) => task.id == taskID);
      taskList[taskIndex] = newTask;
      filteredList = taskList;
    });
  }

  void _editTaskStatus(Task task) {
    setState(() {
      var taskIndex = taskList.indexWhere(
          (element) => element.taskDescription == task.taskDescription);
      taskList[taskIndex] = task;
      filteredList = taskList;
    });
  }

  void _deleteTask(Task task) {
    var taskIndex = taskList.indexOf(task);
    setState(() {
      taskList.removeWhere((element) => element.id == task.id);
      filteredList = taskList;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          textColor: const Color.fromARGB(255, 111, 58, 202),
          label: 'undo',
          onPressed: () => setState(() {
            taskList.insert(taskIndex, task);
          }),
        ),
        content: const Text('Task Deleted !')));
  }

  void _clearFilters() {
    setState(() {
      _chosenCategory = null;
      _chosenStatus = null;
      filteredList = taskList;
    });
  }

  void _filterTaskCategory(Category category) {
    setState(() {
      _chosenCategory = category;
      filteredList = taskList;
      var tempList = filteredList;
      if (_chosenStatus != null) {
        filteredList = tempList
            .where((task) =>
                task.status == _chosenStatus &&
                task.category == _chosenCategory)
            .toList();
      } else {
        filteredList =
            tempList.where((task) => task.category == _chosenCategory).toList();
      }
    });
  }

  void _filterTaskStatus(Status status) {
    setState(() {
      _chosenStatus = status;
      filteredList = taskList;
      var tempList = filteredList;
      if (_chosenCategory != null) {
        filteredList = tempList
            .where((task) =>
                task.status == _chosenStatus &&
                task.category == _chosenCategory)
            .toList();
      } else {
        filteredList =
            tempList.where((task) => task.status == _chosenStatus).toList();
      }
    });
  }

  void addTask(Task task) {
    setState(() {
      taskList.add(task);
    });
  }

  void _openAddTask() {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(116, 200, 155, 255),
      context: context,
      builder: (context) => NewTask(
        addNewTask: addTask,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget contentList = Center(
      child: Text(
        'No task to be done. Start addding !',
        style: TextStyle(color: Colors.deepPurple.shade100),
      ),
    );
    if (filteredList.isNotEmpty) {
      contentList = ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) => TaskItem(
          task: filteredList[index],
          editStatus: _editTaskStatus,
          deleteTask: _deleteTask,
          onEdit: _onEditAlert,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 207, 182, 249).withOpacity(0.3),
        title: Text(
          'TASKs',
          style: GoogleFonts.teko(
              color: Colors.deepPurple.shade400,
              fontStyle: FontStyle.italic,
              fontSize: 30,
              fontWeight: FontWeight.w800),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: _openAddTask,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(1, 2),
                      color: Color.fromARGB(255, 132, 90, 201))
                ],
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 204, 185, 238),
                      Color.fromARGB(255, 114, 80, 174)
                    ])),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: const Color.fromARGB(255, 197, 163, 255),
        shape: const CircularNotchedRectangle(),
        color: Colors.deepPurple.withOpacity(0.6),
        height: 40,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    radius: 0.5,
                    center: const Alignment(-0.7, -0.5),
                    colors: [
                  const Color.fromARGB(255, 236, 148, 148),
                  Colors.white.withOpacity(0)
                ])),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    radius: 2,
                    center: const Alignment(2, 1),
                    colors: [
                  const Color.fromARGB(255, 131, 230, 182),
                  const Color.fromARGB(255, 193, 197, 240).withOpacity(0.3)
                ])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // status filter and graph row
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white.withOpacity(0.4)),
                        child: TaskGraph(taskList: taskList),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...Status.values
                                .map(
                                  (status) => StatusItem(
                                      iconColor: statusColors[status]!,
                                      onChoose: _filterTaskStatus,
                                      status: status),
                                )
                                .toList()
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.3)),
                        child: Row(
                            // category filter
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...Category.values.map((category) => IconButton(
                                  onPressed: () =>
                                      _filterTaskCategory(category),
                                  tooltip: category.name,
                                  icon: Icon(
                                    categoryIcons[category],
                                    color: Color.fromARGB(255, 136, 0, 255),
                                  )))
                            ]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.white)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white
                            ]),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 0, right: 20, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your tasks ...',
                                  style: GoogleFonts.teko(
                                      color: Colors.deepPurple, fontSize: 20),
                                ),
                                TextButton(
                                    onPressed: () => _clearFilters(),
                                    child: const Text(
                                      'clear filters',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 202, 161, 255)),
                                    ))
                              ],
                            ),
                          ),
                          Expanded(child: contentList)
                        ]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
