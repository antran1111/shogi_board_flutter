import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shogi_board/models/board_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shogi_board/screens/board_screen.dart';

class MenuScreen extends StatelessWidget {
  static String id = '/menu';
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
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
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final tactics = snapshot.data.documents;
                  Provider.of<BoardData>(context, listen: false)
                      .setKaisetuList(tactics);
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
                              print(tactics[index]['title'].split('\\n'));
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
