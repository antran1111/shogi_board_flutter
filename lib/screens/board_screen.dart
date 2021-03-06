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
    double komaSize = size.width / 11 * 0.8 +3;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "戦法解説",
            style: TextStyle(),
          ),
        ),
        // 下のバー　
        // １つ前の分岐もしくは一番最初にもどる
        // １手戻る、１手進む
        // 分岐の選択
        // 反転
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
            List<int> nextMoves = boardData.nextIndexList();
            if (nextMoves.length == 0){
              nextMoves.add(0);
            }

            return Row(
              children: <Widget>[
                IconButton(
                    iconSize: 55,
                    color: Colors.white,
                    icon: Icon(Icons.first_page),
                    onPressed: () => boardData.backInitialState()),
                IconButton(
                    iconSize: 35,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back_ios, ),
                    onPressed: () => boardData.backTurn()),
                IconButton(
                    iconSize: 35,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () => boardData.nextTurn()),
                // 次の指し手（分岐がある場合は選択肢がドロップダウンででる領域
                // MEMO: 戻ったときに分岐の選択肢が一番最初の選択肢に戻っている
                // 分岐がない場合はドロップダウンを表示しない（押しても反応しない）ようにしたほうがわかりやすい？ 
                // if文でwidgetを出し分けるのもあり
            DropdownButton<int>(
              value: boardData.selectedMoveIndex,
              dropdownColor: Colors.green,
              onChanged: (tapIndex) =>boardData.setSelectedMoveIndex(tapIndex),
              items: nextMoves.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text( boardData.kaisetu.tejun[value].moveStr == null ? '' : boardData.kaisetu.tejun[value].moveStr,
                  style: TextStyle(color: Colors.white, fontSize: 16),),
                );
              }).toList(),
            ),
                IconButton(
                  iconSize: 35,
                  color: Colors.white,
                  icon: Icon(Icons.screen_rotation),
                  onPressed: () => boardData.flipBoard(),
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
                          int count = boardData.isFlippedBoard
                              ? boardData.kaisetu.tejun[boardData.currentTurn]
                                  .sentehands[kHandsOrder[index]]
                              : boardData.kaisetu.tejun[boardData.currentTurn]
                                  .gotehands[kHandsOrder[index]];

                          return handKoma(
                            kKifPieceToImageFilename[kGoteHandsOrderToSVG[index]],
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
                    child:
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Image.asset('assets/images/shogiban_sente.png',
                        ),
                      Container(
                        margin: EdgeInsets.all(30),
                        //decoration: //new BoxDecoration(
                            //border: new Border.all(
                            //    color: Colors.black87, width: 0.5)),
                        child: GridView.builder(
                          key: GlobalKey(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 9,
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              key: Key(index.toString()),
                              decoration: BoxDecoration(
//                              color: Color(0xFFeeaf6a),
//                              // 枠線
//                              border:
//                                  //Border.all(color: Colors.black87, width: 0.5),
//                              Border(right: kCellBorderSide,
//                                top: kCellBorderSide,
//                                left: kCellBorderSide,
//                                bottom: kCellBorderSide,
//                              ), //color: Colors.black54, width: 0.5),
                              ),
                              child: Container(
                                alignment: Alignment(0.5, 1),
                                child: Consumer<BoardData>(
                                    builder: (context, boardData, child) {
                                  int boardIndex = index;
                                  String cellStr = ' ・';
                                  if (boardData.isFlippedBoard) {
                                    boardIndex = 80 - boardIndex;
                                    cellStr = boardData
                                        .kaisetu.tejun[boardData.currentTurn]
                                        .getMasu(boardIndex);
                                    if (cellStr == ' ・') {
                                    } else if (cellStr.startsWith(' ')) {
                                      cellStr = 'v' + cellStr.substring(1);
                                    } else {
                                      cellStr = ' ' + cellStr.substring(1);
                                    }
                                  } else {
                                    cellStr = boardData
                                        .kaisetu.tejun[boardData.currentTurn]
                                        .getMasu(boardIndex);
                                  }
                                  return SvgPicture.asset(
                                    kKifPieceToImageFilename[cellStr],
                                    height: komaSize,
                                    width: komaSize,
                                    //alignment: Alignment(0.6, 1),
                                  );
                                }),
                              ),
                            );
                          },
                          itemCount: 81,
                        ),
                      ),
                      ]
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
                          int count = boardData.isFlippedBoard
                              ? boardData.kaisetu.tejun[boardData.currentTurn]
                                  .gotehands[kHandsOrder[index]]
                              : boardData.kaisetu.tejun[boardData.currentTurn]
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
                        boardData.kaisetu.tejun[boardData.currentTurn].memo,
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
        ));
  }
}

Widget branch(BoardData boardData) {
  List<dynamic> nextHandBranch =
      boardData.kaisetu.tejun[boardData.currentTurn].node['children'];
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
        child: Stack(children: <Widget>[
          Positioned(
            child: SvgPicture.asset(filename,
              height: komaSize,
              width: komaSize,
              //alignment: Alignment(0.5, 1),
            ),
          ),
          Positioned(
          left: komaSize - 8,
          top: komaSize / 8,
          child: Text('$count', style: TextStyle(fontSize: 14),)),
        ]));
  }
}
