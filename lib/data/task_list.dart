import 'package:task_app/models/task_model.dart';

class TaskList {
  List<Task> taskList = [
    Task(
        taskDescription: 'say the right thing',
        date: DateTime.now(),
        status: Status.onGoing,
        category: Category.personal),
    Task(
        taskDescription: 'act the wrong way',
        date: DateTime.now(),
        status: Status.newTasks,
        category: Category.business),
    Task(
        taskDescription: 'pretend to be nice',
        date: DateTime.now(),
        status: Status.finished,
        category: Category.health),
    Task(
        taskDescription: 'Be brave and be nice.',
        date: DateTime.now(),
        status: Status.onGoing,
        category: Category.goal)
  ];
  List<Task> get getTaskList {
    return taskList;
  }
}

class TaskBucket {
  const TaskBucket({required this.tasksByStatus, required this.status});
  final List<Task> tasksByStatus;
  final Status status;
  TaskBucket.byStatus(List<Task> taskList, this.status)
      : tasksByStatus =
            taskList.where((task) => task.status == status).toList();
  int get taskBucketLength {
    return tasksByStatus.length;
  }
}
