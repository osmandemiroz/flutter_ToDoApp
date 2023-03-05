import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_todoapp/components/buttons.dart';
import 'package:flutter_todoapp/components/todo_list.dart';
import 'package:flutter_todoapp/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _myBox = Hive.box('mybox');

  Database db = Database();

  final TextEditingController _taskTitle = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("tasks") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void changeCheckBox(bool? value, int index) {
    setState(() {
      db.taskList[index][2] = !db.taskList[index][2];
    });
    db.updataDatabase();
  }

  void removeTask(int index) {
    setState(() {
      db.taskList.removeAt(index);
    });
    db.updataDatabase();
  }

  void addNewTask() {
    setState(() {
      db.taskList.add([_taskTitle.text, _description.text, false]);
      _taskTitle.clear();
      _description.clear();
    });
    Navigator.of(context).pop();
    db.updataDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: _taskTitle,
                  decoration: const InputDecoration(
                      hintText: 'Enter Your Task Name',
                      border: OutlineInputBorder()),
                ),
                const Spacer(),
                TextField(
                  controller: _description,
                  decoration: const InputDecoration(
                      hintText: 'Enter Your Task',
                      border: OutlineInputBorder()),
                ),
                Row(
                  children: [
                    MyButtons(text: 'Save', onPressed: addNewTask),
                    const Spacer(),
                    MyButtons(
                        text: 'Cancel',
                        onPressed: () => Navigator.of(context).pop())
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButtonCustomized(),
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: db.taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return ToDoList(
                taskName: db.taskList[index][0],
                taskDescription: db.taskList[index][1],
                isTaskCompleted: db.taskList[index][2],
                onChanged: (value) => changeCheckBox(value, index),
                deleteTask: () => removeTask(index));
          },
        ),
      ),
    );
  }

  SpeedDial floatingActionButtonCustomized() {
    return SpeedDial(
      overlayColor: Colors.white,
      overlayOpacity: 0.4,
      backgroundColor: Colors.redAccent,
      animatedIcon: AnimatedIcons.add_event,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.add_outlined),
          label: 'Add Event',
          onTap: () {
            createNewTask();
          },
        ),
      ],
    );
  }
}
