import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_stuff/utils/constant.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isChecked;
  final Function(bool?) onChanged;
  final Function(BuildContext) deleteToDo;
  const ToDoTile(
      {super.key,
      required this.taskName,
      required this.isChecked,
      required this.onChanged,
      required this.deleteToDo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 12.w),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SizedBox(width: 8.w),
            SlidableAction(
              onPressed: deleteToDo,
              icon: Icons.delete,
              foregroundColor: kWhite,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8.r),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: kPurpleDeep[200],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: onChanged,
                activeColor: kPurpleDeep,
              ),
              Expanded(
                child: Text(
                  taskName,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: kBlack,
                      overflow: TextOverflow.ellipsis,
                      decoration: isChecked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
