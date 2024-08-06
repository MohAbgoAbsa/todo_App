import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app_colors.dart';
import 'package:untitled/edittask/edit_task_screen.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/providers/provids.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatelessWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangeProvi>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          extentRatio: 0.5,

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              onPressed: (context) {
                FirebaseUtils.deleteTaskToFireStore(task)
                    .timeout(const Duration(milliseconds: 500), onTimeout: () {
                  print('taskdelete');
                  provider.getAllTaskFromFirestor();
                });
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.of(context).pushNamed(EditTaskScreen.routeName,
                    arguments: recivedata(task: task));
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),

        child: Container(
          // margin: const EdgeInsets.only(top: 5,bottom: 5,right: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 150,
                color: task.isDone == false
                    ? AppColors.primaryColor
                    : AppColors.greenColor,
              ),
              Expanded(
                  child: ListTile(
                title: Text(
                  task.title,
                  style: task.isDone == false
                      ? Theme.of(context).textTheme.displayLarge
                      : Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.greenColor),
                ),
                subtitle: Text(
                  task.description,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: AppColors.blackColor),
                ),
              )),
              task.isDone == false
                  ? InkWell(
                      onTap: () {
                        FirebaseUtils.updateDoneTaskToFireStore(task).timeout(
                            const Duration(milliseconds: 500), onTimeout: () {
                          print('taskUDone');
                          provider.getAllTaskFromFirestor();
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text('Done!',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.greenColor)),
            ],
          ),
        ),
      ),
    );
  }
}
