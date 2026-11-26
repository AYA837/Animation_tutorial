import 'package:flutter/material.dart';
import 'package:my_app/screens/login.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//library that we use to show the operating system the dart code is currently running on
//show keyword to access only the platform functionality in the file
import 'dart:io' show Platform;

import 'screens/todo.dart';

void main() {
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginScreen());
  }
}