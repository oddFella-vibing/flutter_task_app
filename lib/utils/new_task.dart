import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/models/task_model.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.addNewTask});
  final void Function(Task task) addNewTask;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _taskController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.personal;

  void _onAddTask() {
    widget.addNewTask(Task(
        taskDescription: _taskController.text,
        date: _selectedDate!,
        status: Status.newTasks,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        
        width: double.infinity,
        decoration: BoxDecoration(
          border:const Border(top: BorderSide(color: Colors.white)),
            color:Color.fromARGB(255, 169, 106, 237).withOpacity(0.5),
            borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(children: [
          const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 206, 206, 206),
          ),
          const SizedBox(
            height: 30,
          ),
          // taskfield category dropdown datepicker submit button cancel
          TextField(
            controller: _taskController,
            maxLength: 50,
            decoration:  InputDecoration(
                hintText: 'Task to be done',
                hintStyle: GoogleFonts.patrickHand(color: Color.fromARGB(255, 232, 231, 232),fontSize: 20)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                icon:const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                dropdownColor:const Color.fromARGB(255, 173, 147, 220),
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                        value: category,

                        child: Row(
                          
                          children: [
                            Icon(categoryIcons[category],color:Color.fromARGB(255, 203, 173, 255) ,),
                            const SizedBox(width: 5,),
                            Text(
                              category.name,
                              style: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 233, 231, 236)),
                            ),
                          ],
                        )))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(
                    Icons.calendar_month,
                    color: Color.fromARGB(255, 210, 188, 247),
                  )),
            ],
          ),
          const SizedBox(
            height: 150,
          ),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 206, 186, 244),
                      Colors.deepPurple.shade400
                    ]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.deepPurple.shade600,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(3, 5)),
                  const BoxShadow(
                      color: Color.fromARGB(255, 195, 175, 232),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(-3, -3))
                ]),
            child: TextButton(
                onPressed: _onAddTask,
                child: Text(
                  'save',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ]),
      ),
    );
  }
}
