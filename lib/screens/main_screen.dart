import 'package:flutter/material.dart';
import 'package:shogi_board/constants.dart';
import 'package:provider/provider.dart';
import 'package:shogi_board/models/board_data.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<BoardData>(builder: (context, boardData, child) {
      int kyokumenIndex = boardData.index;
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
                  Row(children: <Widget>[
                    Container(
                      height: size.width / 11 * 7,
                      width: size.width / 11,
                      color: khandsColor,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          int count = boardData.kaisetu.tejun[kyokumenIndex]
                              .gotehands[kHandsOrder[index]];
                          return Container(
                            child: Center(
                                child: Text(
                              count > 0 ? '${kHandsOrder[index]}$count' : '',
                              style: TextStyle(fontSize: 16),
                            )),
                          );
                        },
                        itemCount: 7,
                      ),
                    ),
                    Container(
                      height: size.width * 9 / 11,
                      width: size.width * 9 / 11,
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
                                boardData.kaisetu.tejun[kyokumenIndex]
                                    .getMasu(index),
                                style: TextStyle(fontSize: 16),
                              )),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, -1),
                      height: size.width / 11 * 7,
                      width: size.width / 11,
                      color: khandsColor,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          int count = boardData.kaisetu.tejun[kyokumenIndex]
                              .sentehands[kHandsOrder[index]];
                          return Container(
                            child: Center(
                                child: Text(
                              count > 0 ? '${kHandsOrder[index]}$count' : '',
                              style: TextStyle(fontSize: 16),
                            )),
                          );
                        },
                        itemCount: 7,
                      ),
                    ),
                  ]),
                  Container(
                    height: 250,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        boardData.kaisetu.tejun[kyokumenIndex].memo,
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
            ),
          ));
    });
  }
}
