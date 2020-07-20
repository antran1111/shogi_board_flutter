import 'package:flutter/material.dart';
import 'package:shogi_board/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '将棋戦法解説',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'sawarabi',
      ),
      home: MainScreen(),
    );
  }
}
