import 'package:hive_flutter/hive_flutter.dart';

class ToDoDB {
  List toDoList = [];

//refrence of box
  final _myBox = Hive.box('mybox');

//create db
  void createDataBase() {
    toDoList = [
      ["Welcome to TODO Stuff App!", false],
    ];
  }

//load db
  void loadDataBase() {
    toDoList = _myBox.get('TODOStuff');
  }

//update db
  void updateDataBase() {
    _myBox.put('TODOStuff', toDoList);
  }
}
