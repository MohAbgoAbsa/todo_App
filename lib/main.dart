import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app_themes.dart';
import 'package:untitled/auth/login/login.dart';
import 'package:untitled/edittask/edit_task_screen.dart';
import 'package:untitled/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/providers/provids.dart';

import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyAglMXrre53dwvGw5I-miFfFlEUwIzCYSg',
              appId: 'com.example.untitled',
              messagingSenderId: '355157258026',
              projectId: 'final-to-do-app-244ce'))
      : await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => ChangeProvi(), child: const testfirebase()));
}

class testfirebase extends StatelessWidget {
  const testfirebase({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChangeProvi>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Loginscreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        EditTaskScreen.routeName: (context) => const EditTaskScreen(),
        Loginscreen.routeName: (context) => Loginscreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.selectlang),
      theme: AppThemes.themeLigt,
      darkTheme: AppThemes.themeDark,
      themeMode: provider.themeMode,
    );
  }
}
