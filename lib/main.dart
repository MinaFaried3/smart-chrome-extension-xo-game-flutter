import 'package:flutter/material.dart';

import 'game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //makes text white by default
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF00061a),
        shadowColor: const Color(0xFF001456),
        splashColor: const Color(0xFF4169e8),
        useMaterial3: true,
      ),
      home: const GamePage(),
    );
  }
}
