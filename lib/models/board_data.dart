import 'package:flutter/foundation.dart';
import 'package:shogi_board/models/kaisetu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shogi_board/constants.dart';

// 盤面情報モデル
// タップされた情報に基づいて値を更新する
class BoardData extends ChangeNotifier {
  bool isFlippedBoard = false; // 画面を反転させるか
  Kaisetu kaisetu;
  List<Kaisetu> _kaisetuList = [];
  List<String> currentKif;
  String currentTitle;
  int index = 0;

  List<Kaisetu> get kaisetsuList => _kaisetuList;

  BoardData() {
    index = 0;
    kaisetu = Kaisetu(kif: kif1);
  }

  void nextTurn() {
    if (kaisetu.tejun[index].node['children'].length > 0) {
      index = kaisetu.tejun[index].node['children'][0];
    } else {
      index = 0;
    }
    notifyListeners();
  }

  void backTurn() {
    if (kaisetu.tejun[index].node['parent'] >= 0) {
      index = kaisetu.tejun[index].node['parent'];
    } else {
      // 初期盤面だと伝える？
      // 今のところ何も起こらない
    }
    notifyListeners();
  }

  // 画面を反転させる
  void flipBoard() {
    isFlippedBoard = !isFlippedBoard;
    notifyListeners();
  }

  void setKaisetu(List<DocumentSnapshot> snapshot, int index) async {
    currentTitle = snapshot[index].data['title'].toString();
    currentKif = snapshot[index].data['kif'].split('\\n');
    currentKif = currentKif.map((line) => line.trim()).toList();
    kaisetu = Kaisetu(kif: currentKif);
    // 初期盤面が後手番スタートなら盤面を反転させる
    if (kaisetu.tejun[0].senteban == nextGoteban) {
      isFlippedBoard = true;
    }
  }
}

List<String> kif1 = [
  '# ---- Kifu for Mac V0.24 棋譜ファイル ----',
  '手合割：平手',
  '先手：',
  '後手：',
  '手数----指手---------消費時間--',
  '*初期盤面',
  '1 ７六歩(77)   ( 0:03/00:00:03)',
  '*角道を開ける最も自然な手',
];
