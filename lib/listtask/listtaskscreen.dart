import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/listtask/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:untitled/providers/provids.dart';

class ListTaskScreen extends StatefulWidget {
  const ListTaskScreen({super.key});

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangeProvi>(context);

    if (provider.taskList.isEmpty) {
      provider.getAllTaskFromFirestor();
    }
    return Column(
      children: [
        ///Clander
        EasyDateTimeLine(
          initialDate: provider.selectDate,
          onDateChange: (selectedDate) {
            provider.changSelectDate(selectedDate);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),

        /// Display Task Item List
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem(
                task: provider.taskList[index],
              );
            },
            itemCount: provider.taskList.length,
          ),
        ),
      ],
    );
  }
}
