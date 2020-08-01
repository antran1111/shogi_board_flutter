import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shogi_board/models/board_data.dart';
import 'package:shogi_board/screens/board_screen.dart';

class MenuScreen extends StatelessWidget {
  static String id = '/menu';
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    print('hello2');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "戦法解説",
            style: TextStyle(),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('tactics').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // 非同期処理未完了 = 通信中
                    print('通信中！');
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final tactics = snapshot.data.documents;
                  print('tactics');
                  print(tactics);

                  return ListView.builder(
                      itemCount: tactics.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black38),
                            ),
                          ),
                          child: ListTile(
                            title: Text(tactics[index]['title']),
                            onTap: () {
                              Provider.of<BoardData>(context, listen: false)
                                  .setKaisetu(tactics, index);
                              print("### ${tactics[index]['title']}");
                              Navigator.pushNamed(context, BoardScreen.id);
                            },
                          ),
                        );
                      });
                }),
          ),
        ));
  }
}
