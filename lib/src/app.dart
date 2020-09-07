import 'package:flutter/material.dart';
import 'package:todo_list/screens/categories_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoriesScreen(),
    );
  }
}
