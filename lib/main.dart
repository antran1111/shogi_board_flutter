import 'package:flutter/material.dart';
import 'package:shogi_board/screens/board_screen.dart';
import 'package:shogi_board/screens/menu_screen.dart';
import 'package:shogi_board/models/board_data.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BoardData>(
      create: (_) => BoardData(),
      child: MaterialApp(
        title: '将棋戦法解説',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'notosans-medium',
          //fontFamily: 'kosugi',
          //fontFamily: 'mplus1',
        ),
        initialRoute: MenuScreen.id,
        routes: {
          MenuScreen.id: (context) => MenuScreen(),
          BoardScreen.id: (context) => BoardScreen(),
        },
      ),
    );
  }
}
