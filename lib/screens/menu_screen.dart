import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shogi_board/models/board_data.dart';
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
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }

                  final tactics = snapshot.data.documents;

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
