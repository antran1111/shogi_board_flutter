import 'package:flutter/material.dart';
import 'package:shogi_board/constants.dart';
import 'package:provider/provider.dart';
import 'package:shogi_board/models/board_data.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<BoardData>(builder: (context, boardData, child) {
      //turn = 0;
      //kaisetu = boardData.Kaisetu(kif: kif1);
      //boardData.setInitial();
      int turn = boardData.turn;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "戦法解説",
            style: TextStyle(),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: size.width / 10,
                      width: size.width / 10 * 7,
                      color: khandsColor,
                      child: GridView.count(
                        crossAxisCount: 7,
                        children: List<Widget>.generate(7, (index) {
                          //final piece = boardData.cell(index);
                          List<String> handsOrder = [
                            '飛',
                            '角',
                            '金',
                            '銀',
                            '桂',
                            '香',
                            '歩'
                          ];
                          var hands = boardData.kaisetu.tejun[turn].gotehands;
                          var count = hands[handsOrder[index]];
                          return Container(
                            child: Center(
                                child: Text(
                              count > 0 ? '${handsOrder[index]}$count' : '',
                              style: TextStyle(fontSize: 16),
                            )),
                          );
                        }),
                      ),
                    ),
                    Container(
                      height: size.width,
                      width: size.width,
                      color: kBoardColor,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: new BoxDecoration(
                            border:
                                new Border.all(color: kKeisenColor, width: 1)),
                        child: GridView.count(
                          crossAxisCount: 9,
                          children: List<Widget>.generate(81, (index) {
                            //final piece = boardData.cell(index);
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFf2c077),
                                // 枠線
                                border:
                                    Border.all(color: kKeisenColor, width: 1),
                              ),
                              //color: Color(0xFFf2c077),
                              child: Center(
                                  child: Text(
                                boardData.kaisetu.tejun[turn].getMasu(index),
                                style: TextStyle(fontSize: 16),
                              )),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, -1),
                      height: size.width / 10,
                      width: size.width / 10 * 7,
                      color: khandsColor,
                      child: GridView.count(
                        crossAxisCount: 7,
                        children: List<Widget>.generate(7, (index) {
                          //final piece = boardData.cell(index);
                          List<String> handsOrder = [
                            '飛',
                            '角',
                            '金',
                            '銀',
                            '桂',
                            '香',
                            '歩'
                          ];
                          int count = boardData.kaisetu.tejun[turn]
                              .sentehands[handsOrder[index]];
                          return Container(
                            child: Center(
                                child: Text(
                              count > 0 ? '${handsOrder[index]}$count' : '',
                              style: TextStyle(fontSize: 16),
                            )),
                          );
                        }),
                      ),
                    ),
                    Container(
                      height: 150,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          boardData.kaisetu.tejun[turn].memo,
                          style: new TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                            iconSize: 35,
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () => boardData.backTurn()),
                        IconButton(
                            iconSize: 35,
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () => boardData.nextTurn()),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
