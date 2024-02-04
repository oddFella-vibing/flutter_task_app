import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:task_app/models/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {super.key,
      required this.task,
      required this.editStatus,
      required this.deleteTask,
      required this.onEdit});
  final Task task;
  final Function(Task task) onEdit;
  final Function(Task task) editStatus;
  final Function(Task task) deleteTask;

  void onEditStatus(Status status) {
    var updatedTask = Task(
        taskDescription: task.taskDescription,
        date: task.date,
        status: status,
        category: task.category);

    editStatus(updatedTask);
  }

  void onDeleteTask() {
    deleteTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.only(top: 20, bottom: 2),
        decoration: BoxDecoration(
            color: Colors.deepPurple.shade500,
            borderRadius: BorderRadius.circular(20)),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              padding: EdgeInsets.only(right: 2),
              onPressed: (context) => {onEditStatus(Status.onGoing)},
              icon: Icons.sync,
              backgroundColor: Colors.transparent,
            ),
            SlidableAction(
              padding: EdgeInsets.only(right: 5),
              onPressed: (context) => {onEditStatus(Status.finished)},
              icon: Icons.done_all,
              backgroundColor: Colors.transparent,
            ),
            SlidableAction(
              padding: EdgeInsets.only(right: 5),
              onPressed: (context) => {onEditStatus(Status.canceled)},
              icon: Icons.block,
              backgroundColor: Colors.transparent,
            ),
            SlidableAction(
              padding: EdgeInsets.only(right: 5),
              onPressed: (context) => {onDeleteTask()},
              icon: Icons.delete_forever,
              backgroundColor: Colors.transparent,
            )
          ]),
          child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 18, left: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: statusColors[task.status]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.taskDescription,
                      style: GoogleFonts.patrickHand(
                          decorationColor: Colors.white,
                          decoration: task.status == Status.finished ||
                                  task.status == Status.canceled
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          categoryIcons[task.category],
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          task.formattedDate,
                          style: GoogleFonts.cuteFont(
                              color: Colors.white, fontSize: 18),
                        ),
                        IconButton(onPressed: () =>onEdit(task), icon: Icon(Icons.edit_square,color: Colors.white,size: 18,))
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      statusIcons[task.status],
                      size: 70,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                      color: Color.fromARGB(255, 230, 230, 230),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
