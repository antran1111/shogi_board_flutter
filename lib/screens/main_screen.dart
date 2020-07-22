import 'package:flutter/material.dart';
import 'package:shogi_board/constants.dart';
import 'package:shogi_board/models/kaisetu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kaisetu = Kaisetu();
    print(kaisetu.Tejun[0].board);

    final Size size = MediaQuery.of(context).size;
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
                      height: size.width / 12,
                      width: size.width / 12 * 7,
                      color: khandsColor,
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
                                kaisetu.Tejun[0].getMasu(index),
                                style: TextStyle(fontSize: 16),
                              )),
                            );
                          }),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, -1),
                      height: size.width / 12,
                      width: size.width / 12 * 7,
                      color: khandsColor,
                    ),
                    Container(
                      height: 170,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          kaisetu.Tejun[0].memo,
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
                            onPressed: null),
                        IconButton(
                            iconSize: 35,
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: null),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
