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
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          notchMargin: 6.0,
          shape: AutomaticNotchedShape(
            RoundedRectangleBorder(),
            StadiumBorder(
              side: BorderSide(),
            ),
          ),
          child: Consumer<BoardData>(builder: (context, boardData, child) {
            return Row(
              children: <Widget>[
                IconButton(
                    iconSize: 35,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => boardData.backTurn()),
                IconButton(
                    iconSize: 35,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () => boardData.nextTurn()),
                // 次の指し手（分岐がある場合は選択肢がドロップダウンででる領域
                DropdownButton<String>(
                  value: '☗５六歩',
                  dropdownColor: Colors.white,
                  onChanged: (line) => print("tap_$line!!"),
                  items: <String>[
                    '☗５六歩',
                    '☗４六歩',
                    '☗３六銀',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            );
          }),
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
                    child: ListView.separated(
                      reverse: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(),
                      itemBuilder: (BuildContext context, index) {
                        return Consumer<BoardData>(
                            builder: (context, boardData, child) {
                          int count = boardData.kaisetu.tejun[boardData.index]
                              .gotehands[kHandsOrder[index]];
                          return handKoma(
                            kKifPieceToImageFilename[
                                kGoteHandsOrderToSVG[index]],
                            count,
                            komaSize,
                            'gotehand$index',
                          );
                        });
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
                        key: GlobalKey(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 9,
                        ),
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            key: Key(index.toString()),
                            decoration: BoxDecoration(
                              color: Color(0xFFf2c077),
                              // 枠線
                              border:
                                  Border.all(color: Colors.black54, width: 0.5),
                            ),
                            child: Center(
                              child: Consumer<BoardData>(
                                  builder: (context, boardData, child) {
                                return SvgPicture.asset(
                                  kKifPieceToImageFilename[boardData
                                      .kaisetu.tejun[boardData.index]
                                      .getMasu(index)],
                                  height: komaSize,
                                  width: komaSize,
                                );
                              }),
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
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(),
                      itemBuilder: (BuildContext context, index) {
                        return Consumer<BoardData>(
                            builder: (context, boardData, child) {
                          int count = boardData.kaisetu.tejun[boardData.index]
                              .sentehands[kHandsOrder[index]];

                          return handKoma(
                            kKifPieceToImageFilename[
                                kSenteHandsOrderToSVG[index]],
                            count,
                            komaSize,
                            'sentehand$index',
                          );
                        });
                      },
                      itemCount: 7,
                    ),
                  ),
                ]),
                Container(
                  height: size.height - boardSize - 200,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Consumer<BoardData>(
                        builder: (context, boardData, child) {
                      return Text(
                        boardData.kaisetu.tejun[boardData.index].memo,
                        style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      );
                    }),
                  ),
                ),
                //branch(boardData),
              ],
            ),
          ),
        ));o
  }
}

Widget branch(BoardData boardData) {
  List<dynamic> nextHandBranch =
      boardData.kaisetu.tejun[boardData.index].node['children'];
  if (nextHandBranch.length > 1) {
    List<Widget> candidates = [];

    return Row(
      children: nextHandBranch.map((index) {
        return Text(boardData.kaisetu.tejun[index].moveStr);
      }).toList(),
    );
  } else {
    return Container();
  }
}

//　駒台の駒の表現
Widget handKoma(String filename, int count, double komaSize, String keyName) {
  // MEMO: keyが効いているかは分からない
  if (count == 0) {
    return Container(
      key: Key(keyName),
    );
  } else {
    return Container(
        key: Key(keyName),
        margin: const EdgeInsets.fromLTRB(3, 3, 0, 3),
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
