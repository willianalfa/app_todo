import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../stores/user_store.dart';
import './screens/home.dart';

void main() {
  runApp(AppToDo());
}

class AppToDo extends StatelessWidget {
  final UserStore userStore = UserStore();

  AppToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App ToDo List',
      home: Home(userStore: userStore),
    );
  }
}