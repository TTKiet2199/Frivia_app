import 'package:flutter/material.dart';
import 'package:frivia_app/pages/game_page.dart';
import 'package:frivia_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frivia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'ArchitectsDaughter',
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0)),
      home: HomePage(),
    );
  }
}
