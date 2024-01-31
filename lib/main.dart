import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hemant_task/category_screen.dart';
import 'package:hemant_task/final_screen.dart';
import 'package:hemant_task/firebase_options.dart';
import 'package:hemant_task/language_screen.dart';
import 'package:hemant_task/phone_screen.dart';
import 'package:hemant_task/state.dart';
import 'package:provider/provider.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => DataState(),
    child: MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: LanguageScreen(),
      routes: {
        PhoneScreen.routeName: (context) => PhoneScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
        FinalScreen.routeName: (context) => FinalScreen()
      },
    ),
  ));
}
