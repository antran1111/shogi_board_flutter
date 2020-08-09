import 'package:flutter/material.dart';
import 'package:shogi_board/constants.dart';
import 'package:provider/provider.dart';
import 'package:shogi_board/models/board_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoardScreen extends StatelessWidget {
  static String id = '/board';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<BoardData>(builder: (context, boardData, child) {
      int kyokumenIndex = boardData.index;
      double boardSize = size.width * 9 / 11;
      double handWidth = size.width / 11;
      double handHeight = size.width / 11 * 7;
      double komaSize = size.width / 11 * 0.8;

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
                      height: handHeight,
                      width: handWidth,
                      color: khandsColor,
                      child: ListView.builder(
                        reverse: true,
                        itemBuilder: (BuildContext context, index) {
                          int count = boardData.kaisetu.tejun[kyokumenIndex]
                              .gotehands[kHandsOrder[index]];
                          return handKoma(
                              kKifPieceToImageFilename[
                                  kGoteHandsOrderToSVG[index]],
                              count,
                              komaSize);
                        },
                        itemCount: 7,
                      ),
                    ),
                    Container(
                      height: boardSize,
                      width: boardSize,
                      color: kBoardColor,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: new BoxDecoration(
                            border: new Border.all(
                                color: Colors.black54, width: 0.5)),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFf2c077),
                                // 枠線
                                border: Border.all(
                                    color: Colors.black54, width: 0.5),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  kKifPieceToImageFilename[boardData
                                      .kaisetu.tejun[kyokumenIndex]
                                      .getMasu(index)],
                                  height: komaSize,
                                  width: komaSize,
                                ),
                              ),
                            );
                          },
                          itemCount: 81,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, -1),
                      height: handHeight,
                      width: handWidth,
                      color: khandsColor,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          int count = boardData.kaisetu.tejun[kyokumenIndex]
                              .sentehands[kHandsOrder[index]];

                          return handKoma(
                              kKifPieceToImageFilename[
                                  kSenteHandsOrderToSVG[index]],
                              count,
                              komaSize);
                        },
                        itemExtent: 7,
                        itemCount: 7,
                      ),
                    ),
                  ]),
                  Container(
                    height: size.height - boardSize - 200,
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
                  branch(boardData),
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

Widget branch(BoardData boardData) {
  List<dynamic> nextHandBranch =
      boardData.kaisetu.tejun[boardData.index].node['children'];
  if (nextHandBranch.length > 1) {
    print(nextHandBranch);
    List<Widget> candidates = [];

    return Row(
      children: nextHandBranch.map((index) {
        print(index);
        print(boardData.kaisetu.tejun[index].moveStr);
        return Text(boardData.kaisetu.tejun[index].moveStr);
      }).toList(),
    );
  } else {
    return Container();
  }
}

//　駒台の駒の表現
Widget handKoma(String filename, int count, double komaSize) {
  if (count == 0) {
    return Container();
  } else {
    return Container(
        margin: EdgeInsets.fromLTRB(3, 3, 0, 3),
        child: Row(children: <Widget>[
          SvgPicture.asset(
            filename,
            height: komaSize,
            width: komaSize * 0.9,
          ),
          Text('$count', style: TextStyle(fontSize: 14)),
        ]));
  }
}
