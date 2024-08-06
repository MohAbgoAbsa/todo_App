import 'package:flutter/material.dart';
import 'package:untitled/listtask/add_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/listtask/listtaskscreen.dart';
import 'package:untitled/settings/settingsscreen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectindex = 0;

  @override
  Widget build(BuildContext context) {
    Localizations.override(context: context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.apptitle,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          toolbarHeight: 100,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          height: MediaQuery.of(context).size.height * 0.098,
          child: BottomNavigationBar(
            onTap: (index) {
              selectindex = index;
              setState(() {});
            },
            currentIndex: selectindex,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list),
                  label: AppLocalizations.of(context)!.tasklist),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.setting),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ShowModalBottonSheet();
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: const BorderSide(width: 5, color: Colors.white)),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body:
            selectindex == 0 ? const ListTaskScreen() : const SettingsScreen());
  }

  void ShowModalBottonSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const AddNewTask());
  }
}
