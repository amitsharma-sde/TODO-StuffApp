import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_stuff/utils/constant.dart';
import 'package:todo_stuff/widgets/custom_button.dart';

class ToDoDialogBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const ToDoDialogBox(
      {super.key,
      this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: kPurpleDeep[100],
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                // maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPurpleDeep,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPurpleDeep,
                      width: 2,
                    ),
                  ),
                  hintText: "Enter Task Name",
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomButton(
                      btnColor: kPurpleDeep[100],
                      textColor: kPurpleDeep,
                      text: "Cancel",
                      onPressed: onCancel,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomButton(
                      text: "Save",
                      onPressed: onSave,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
