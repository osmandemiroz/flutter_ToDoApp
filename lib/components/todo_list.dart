// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ToDoList extends StatelessWidget {
  ToDoList({
    Key? key,
    required this.taskName,
    required this.isTaskCompleted,
    required this.onChanged,
    required this.taskDescription,
    required this.deleteTask,
  }) : super(key: key);
  Function()? deleteTask;
  Function(bool?)? onChanged;
  final bool isTaskCompleted;
  final String taskName;
  final String taskDescription;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: const BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Row(
            children: [
              //checkBox
              Expanded(
                  child:
                      Checkbox(value: isTaskCompleted, onChanged: onChanged)),

              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    //taskName
                    Text(
                      taskName,
                      style: TextStyle(
                          decoration: isTaskCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontWeight: FontWeight.bold),
                    ),

                    //description
                    Text(
                      taskDescription,
                      style: TextStyle(
                        decoration: isTaskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(
                  width: 80,
                ),
              ),
              isTaskCompleted
                  ? Expanded(
                      child: IconButton(
                        onPressed: deleteTask,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Colors.red,
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
