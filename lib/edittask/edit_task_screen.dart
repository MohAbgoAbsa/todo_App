import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app_colors.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/providers/provids.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edittaskscreen';

  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var selectDate = DateTime.now();

  String title = '';

  String description = '';
  bool bcangedate = true;

  var keyform = GlobalKey<FormState>();

  late ChangeProvi changeProvi;

  @override
  Widget build(BuildContext context) {
    recivedata arg = ModalRoute.of(context)!.settings.arguments as recivedata;
    selectDate = bcangedate ? arg.task.datetime : selectDate;
    var provider = Provider.of<ChangeProvi>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.apptitle,
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        toolbarHeight: 100,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            color: AppColors.primaryColor,
          ),
          Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.edittask,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Form(
                    key: keyform,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          initialValue: arg.task.title,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.tasktitle,
                          ),
                          onChanged: (text) => title = text,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .titleerrotmasege;
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: arg.task.description,
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.taskdescription,
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
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (keyform.currentState?.validate() == true) {
                                Task task = Task(
                                    id: arg.task.id,
                                    title: title,
                                    description: description,
                                    datetime: selectDate);
                                FirebaseUtils.updateAllTaskToFireStore(task)
                                    .timeout(const Duration(seconds: 1),
                                        onTimeout: () {
                                  print('Task added successfully');
                                  provider.getAllTaskFromFirestor();
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.savechange,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.whiteColor),
                            )),
                      ],
                    ),
                  )
                ],
              ))
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

    selectDate = changedate ?? selectDate;
    bcangedate = false;
    setState(() {
      // changeProvi.getAllTaskFromFirestor();
    });
  }
}

class recivedata {
  Task task;

  recivedata({required this.task});
}
