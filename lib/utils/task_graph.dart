import 'package:flutter/material.dart';
import 'package:task_app/data/task_list.dart';
import 'package:task_app/models/task_model.dart';

class TaskGraph extends StatelessWidget {
  const TaskGraph({super.key, required this.taskList});
  final List<Task> taskList;

  List<TaskBucket> get taskBuckets {
    return [
      TaskBucket.byStatus(taskList, Status.newTasks),
      TaskBucket.byStatus(taskList, Status.onGoing),
      TaskBucket.byStatus(taskList, Status.finished),
      TaskBucket.byStatus(taskList, Status.canceled),
    ];
  }

  int get maxTaskLength {
    var maxTaskLength = 0;
    for (var taskBucket in taskBuckets) {
      if (taskBucket.taskBucketLength > maxTaskLength) {
        maxTaskLength = taskBucket.taskBucketLength;
      }
    }
    return maxTaskLength;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...taskBuckets
              .map((taskBucket) => Expanded(
                    child: FractionallySizedBox(
                      heightFactor: taskBucket.taskBucketLength == 0
                          ? 0
                          : taskBucket.taskBucketLength / maxTaskLength,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(28),
                              color: statusColors[taskBucket.status]),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  taskBucket.taskBucketLength.toString(),
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 241, 241, 241)),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ))
              .toList()
        ]);
  }
}
