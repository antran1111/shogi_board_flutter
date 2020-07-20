import 'package:flutter/material.dart';
import 'package:shogi_board/constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                                '歩',
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
                          "銀と桂交換なら先手の得。なのでここはooの一手。 " +
                              "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " +
                              "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" +
                              "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" +
                              "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " +
                              "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" +
                              "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" +
                              "8 Description that is too long in text format(Here Data is coming from API)" +
                              "9 Description that is too long in text format(Here Data is coming from API)" +
                              "10 Description that is too long in text format(Here Data is coming from API)",
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
