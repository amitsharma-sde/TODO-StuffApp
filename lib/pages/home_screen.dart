import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_stuff/database/todo_db.dart';
import 'package:todo_stuff/utils/constant.dart';
import 'package:todo_stuff/widgets/custom_button.dart';
import 'package:todo_stuff/widgets/todo_dialog_widget.dart';
import 'package:todo_stuff/widgets/todo_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _mybox = Hive.box('mybox');
  ToDoDB db = ToDoDB();
  final _todoCntrl = TextEditingController();
  List _tempList = [];
  bool todoBoolValue = true;

  @override
  void initState() {
    super.initState();
    if (_mybox.get('TODOStuff') == null) {
      db.createDataBase();
      _tempList = db.toDoList;
    } else {
      db.loadDataBase();
      _tempList = db.toDoList;
    }
  }

  void checkBoxTap(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    if (_todoCntrl.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Please enter Task Name",
          style: TextStyle(color: kWhite),
        ),
      ));
    } else {
      setState(() {
        db.toDoList.add([_todoCntrl.text, false]);
        _todoCntrl.clear();
      });
      db.updateDataBase();
      Navigator.of(context).pop();
    }
  }

  void createToDoTask() {
    showDialog(
        context: context,
        builder: (context) {
          return ToDoDialogBox(
            controller: _todoCntrl,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void _searchToDo(String key) {
    List searchResult = [];
    if (key.isEmpty) {
      searchResult = db.toDoList;
    } else {
      searchResult = db.toDoList
          .where((element) => element[0].toString().contains(key.toLowerCase()))
          .toList();
    }
    setState(() {
      _tempList = searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kPurpleDeep[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: const Center(
          child: Text("TODO"),
        ),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Image.asset(
          'assets/icon/add.png',
          color: kWhite,
          height: 24.h,
          width: 24.h,
        ),
        onPressed: createToDoTask,
        label: const Text("Add Task"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            // width: .9.sw,
            child: TextField(
              controller: null,
              onChanged: (value) => _searchToDo(value),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPurpleDeep,
                    width: 1,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPurpleDeep,
                    width: 1,
                  ),
                ),
                hintText: "Search Task",
                prefixIconColor: kPurpleDeep,
                prefixIcon: Image.asset(
                  'assets/icon/search.png',
                  color: kPurpleDeep,
                  height: 20.h,
                  width: 20.h,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 12.w),
              Expanded(
                  child: CustomButton(
                      btnColor: todoBoolValue ? kPurpleDeep : kPurpleDeep[100],
                      onPressed: () {
                        setState(() {
                          todoBoolValue = true;
                        });
                      },
                      text: "Pending TODO !!!",
                      textColor: todoBoolValue ? kWhite : kPurpleDeep)),
              SizedBox(width: 12.w),
              Expanded(
                  child: CustomButton(
                      btnColor: !todoBoolValue ? kPurpleDeep : kPurpleDeep[100],
                      onPressed: () {
                        setState(() {
                          todoBoolValue = false;
                        });
                      },
                      text: "Completed Task",
                      textColor: !todoBoolValue ? kWhite : kPurpleDeep)),
              SizedBox(width: 12.w),
            ],
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: ListView.builder(
              itemCount: _tempList.length,
              itemBuilder: (context, index) {
                return _tempList[index][1] == todoBoolValue
                    ? const SizedBox()
                    : ToDoTile(
                        taskName: _tempList[index][0],
                        isChecked: _tempList[index][1],
                        onChanged: (value) => checkBoxTap(value, index),
                        deleteToDo: (context) => deleteTask(index),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
