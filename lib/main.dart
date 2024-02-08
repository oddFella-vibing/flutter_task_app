import 'package:flutter/material.dart';
import 'package:task_app/task_home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        useMaterial3: true,
      ),
      home:  TaskHome(),
    );
  }
}

//  Flexible(
//                             flex: 1,
//                             child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 5, vertical: 15),
//                                 height: 200,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                     borderRadius: BorderRadius.circular(25),
//                                     color: Colors.white.withOpacity(0.4)),
//                                 child: GridView.builder(
//                                   itemCount: Status.values.length,
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                           crossAxisSpacing: 10,
//                                           mainAxisSpacing: 10,
//                                           crossAxisCount: 2),
//                                   itemBuilder: (context, index) => StatusItem(
//                                       iconColor:
//                                           statusColors[Status.values[index]]!,
//                                       onChoose: _filterTaskStatus,
//                                       status: Status.values[index]),
//                                 )),
//                           ),