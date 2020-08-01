import 'package:flutter/foundation.dart';
import 'package:shogi_board/models/kaisetu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 盤面情報モデル
// タップされた情報に基づいて値を更新する
class BoardData extends ChangeNotifier {
  Kaisetu kaisetu;
  List<Kaisetu> _kaisetuList = [];
  List<String> currentKif;
  String currentTitle;
  int index = 0;

  List<Kaisetu> get kaisetsuList => _kaisetuList;

  BoardData() {
    index = 0;
    kaisetu = Kaisetu(kif: kif2);
    // kaisetu = Kaisetu(kif: kif_bunki);
  }

  void nextTurn() {
    print(kaisetu.tejun[index].node['children']);
    if (kaisetu.tejun[index].node['children'].length > 0) {
      index = kaisetu.tejun[index].node['children'][0];
    } else {
      index = 0;
    }
    notifyListeners();
  }

  void backTurn() {
    print(kaisetu.tejun[index].node['children']);
    if (kaisetu.tejun[index].node['parent'] >= 0) {
      index = kaisetu.tejun[index].node['parent'];
    } else {
      // 初期盤面だと伝える？
    }
    notifyListeners();
  }

  void setKaisetu(List<DocumentSnapshot> snapshot, int index) async {
    currentTitle = snapshot[index].data['title'];
    currentKif = snapshot[index].data['kif'].split('\\n');
    currentKif = currentKif.map((line) => line.trim()).toList();
    print(currentKif);
    kaisetu = Kaisetu(kif: currentKif);
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
  '*ここで▲４八銀を上がらずに２筋を交換するのは危険。',
  '*ここで▲４八銀を上がらずに２筋を交換するのは危険。',
];

List<String> kif3 = [
  '# ---- Kifu for Mac V0.24 棋譜ファイル ----',
  '手合割：平手',
  '先手：',
  '後手：',
  '手数----指手---------消費時間--',
  '1 ７六歩(77)   ( 0:03/00:00:03)',
  '2 ８四歩(83)   ( 0:01/00:00:01)',
  '3 ２六歩(27)   ( 0:04/00:00:07)',
  '4 ８五歩(84)   ( 0:01/00:00:02)',
  '5 ７七角(88)   ( 0:01/00:00:08)',
  '6 ３四歩(33)   ( 0:04/00:00:06)',
  '7 ８八銀(79)   ( 0:12/00:00:20)',
  '8 ３二金(41)   ( 0:03/00:00:09)',
  '9 ２五歩(26)   ( 0:04/00:00:24)',
  '10 ７七角成(22) ( 0:03/00:00:12)',
  '11 同　銀(88)   ( 0:01/00:00:25)',
  '12 ２二銀(31)   ( 0:06/00:00:18)',
  '*ここで▲４八銀を上がらずに２筋を交換するのは危険。',
  '13 ２四歩(25)   ( 3:28/00:03:53)',
  '14 同　歩(23)   ( 0:01/00:00:19)',
  '15 同　飛(28)   ( 0:01/00:03:54)',
  '16 ３五角打     ( 0:05/00:00:24)',
  '17 ３四飛(24)   ( 0:07/00:04:01)',
  '18 ５七角成(35) ( 0:02/00:00:26)',
];

List<String> kif2 = [
  '# ---- Kifu for Mac V0.24 棋譜ファイル ----',
  '手合割：平手',
  '先手：',
  '後手：',
  '手数----指手---------消費時間--',
  '1 ７六歩(77)   ( 0:03/00:00:03)',
  '2 ８四歩(83)   ( 0:01/00:00:01)',
  '3 ２六歩(27)   ( 0:04/00:00:07)',
  '4 ８五歩(84)   ( 0:01/00:00:02)',
  '5 ７七角(88)   ( 0:01/00:00:08)',
  '6 ３四歩(33)   ( 0:04/00:00:06)',
  '7 ８八銀(79)   ( 0:12/00:00:20)',
  '8 ３二金(41)   ( 0:03/00:00:09)',
  '9 ２五歩(26)   ( 0:04/00:00:24)',
  '10 ７七角成(22) ( 0:03/00:00:12)',
  '11 同　銀(88)   ( 0:01/00:00:25)',
  '12 ２二銀(31)   ( 0:06/00:00:18)',
  '*ここで▲４八銀を上がらずに２筋を交換するのは危険。',
  '13 ２四歩(25)   ( 3:28/00:03:53)',
  '14 同　歩(23)   ( 0:01/00:00:19)',
  '15 同　飛(28)   ( 0:01/00:03:54)',
  '16 ３五角打     ( 0:05/00:00:24)',
  '17 ３四飛(24)   ( 0:07/00:04:01)',
  '18 ５七角成(35) ( 0:02/00:00:26)',
  '',
  '変化：13手',
  '13 ４八銀(39)   ( 0:17/00:00:42)',
  '14 ６二銀(71)   ( 0:35/00:00:53)',
  '*一見２筋の歩が交換できそうだが。',
  '15 ２四歩(25)   ( 0:04/00:00:46)',
  '16 同　歩(23)   ( 0:04/00:00:57)',
  '17 同　飛(28)   ( 0:02/00:00:48)',
  '18 ８六歩(85)   ( 0:05/00:01:02)',
  '19 同　歩(87)   ( 0:01/00:00:49)',
  '20 ８八歩打     ( 0:06/00:01:08)',
];

List<String> kif_bunki = [
  '# ---- Kifu for Mac V0.24 棋譜ファイル ----',
  '手合割：平手',
  '先手：',
  '後手：',
  '手数----指手---------消費時間--',
  '1 ７六歩(77)   ( 0:01/00:00:01)',
  '2 ３四歩(33)   ( 0:01/00:00:01)',
  '3 ２六歩(27)   ( 0:01/00:00:02)',
  '4 ３五歩(34)   ( 0:01/00:00:02)',
  '5 ２五歩(26)   ( 0:01/00:00:03)',
  '6 ３二飛(82)   ( 0:01/00:00:03)',
  '7 ９六歩(97)   ( 0:02/00:00:05)',
  '8 ９四歩(93)   ( 0:01/00:00:04)',
  '9 ６八玉(59)   ( 0:01/00:00:06)',
  '10 ３四飛(32)   ( 0:03/00:00:07)',
  '11 ７八玉(68)   ( 0:03/00:00:09)',
  '',
  '変化：11手',
  '11 ７五歩(76)   ( 1:12/00:01:18)',
  '12 ８四歩(83)   ( 0:03/00:00:10)',
  '13 ８六歩(87)   ( 0:01/00:01:19)',
  '14 ７二銀(71)   ( 0:02/00:00:12)',
  '15 ７八玉(68)   ( 0:01/00:01:20)',
  '',
  '変化：10手',
  '10 ６二玉(51)   ( 0:14/00:00:18)',
  '11 ７八玉(68)   ( 0:01/00:00:07)',
  '12 ７二玉(62)   ( 0:01/00:00:19)',
  '13 ５八金(49)   ( 0:02/00:00:09)',
  '',
  '変化：11手',
  '11 ５八金(49)   ( 2:10/00:02:16)',
  '12 ７二玉(62)   ( 0:02/00:00:20)',
  '13 ７八玉(68)   ( 0:02/00:02:18)',
  '14 ８二玉(72)   ( 0:01/00:00:21)',
  '',
  '変化：9手',
  '9 １六歩(17)   ( 0:32/00:00:37)',
  '',
  '変化：9手',
  '9 ７五歩(76)   ( 0:38/00:00:43)',
  '10 ８四歩(83)   ( 0:06/00:00:10)',
  '11 ７八銀(79)   ( 0:02/00:00:45)',
  '12 ４四歩(43)   ( 0:02/00:00:12)',
  '13 ６八玉(59)   ( 0:01/00:00:46)',
  '14 ６二玉(51)   ( 0:01/00:00:13)',
  '15 ７九玉(68)   ( 0:01/00:00:47)',
  '16 ３四飛(32)   ( 0:03/00:00:16)',
];
