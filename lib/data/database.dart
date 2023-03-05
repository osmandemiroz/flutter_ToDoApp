import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List taskList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    taskList = [
      ["Title Example", "Description Example", false]
    ];
  }

  void loadData() {
    taskList = _myBox.get("tasks");
  }

  void updataDatabase() {
    _myBox.put("tasks", taskList);
  }
}
