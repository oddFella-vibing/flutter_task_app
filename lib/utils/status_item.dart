import 'package:flutter/material.dart';
import 'package:task_app/models/task_model.dart';

class StatusItem extends StatelessWidget {
  const StatusItem(
      {super.key,
      required this.onChoose,
      required this.status,
      required this.iconColor});
  final Function(Status status) onChoose;
  final Status status;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
shadowColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            backgroundColor: iconColor,
            shape:
                RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(20)),
          ),
          onPressed:()=> onChoose(status),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  statusIcons[status],
                  size: 50,
                  color: Colors.white,
               
                ),
                Text(
                  status.name,
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 10),
                )
              ],
            ),
          )),
    );
  }
}
