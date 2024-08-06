import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app_colors.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/providers/provids.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var selectDate = DateTime.now();
  String title = '';
  String description = '';
  var keyform = GlobalKey<FormState>();
  late ChangeProvi changeProvi;

  @override
  Widget build(BuildContext context) {
    changeProvi = Provider.of<ChangeProvi>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.4506896551724138,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.addnewtask,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Form(
            key: keyform,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.tasktitle),
                  onChanged: (text) => title = text,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.titleerrotmasege;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.taskdescription,
                  ),
                  maxLines: 4,
                  onChanged: (text) => description = text,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!
                          .descriptionerrotmasege;
                    }
                    return null;
                  },
                ),
                Text(
                  AppLocalizations.of(context)!.selectdate,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                InkWell(
                    onTap: () {
                      showClander();
                    },
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(selectDate),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        if (keyform.currentState?.validate() == true) {
                          Task task = Task(
                              title: title,
                              description: description,
                              datetime: selectDate);
                          FirebaseUtils.addTaskToFireStore(task).timeout(
                              const Duration(seconds: 1), onTimeout: () {
                            print('Task added successfully');
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.primaryColor,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 50,
                            color: AppColors.whiteColor,
                          )),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showClander() async {
    var changedate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 356)),
    );

    changeProvi.getAllTaskFromFirestor();

    selectDate = changedate ?? selectDate;

    setState(() {});
  }
}
