import 'package:shogi_board/constants.dart';

class Kaisetu {
  List<Kyokumen> tejun;

  Kaisetu({List<String> kif}) {
    print('きたか');
//    tejun = [
//      Kyokumen(kif: kif),
//      Kyokumen(kif: kif),
//    ];
    bool goteban = false;
    String goteMochigoma = '';
    String senteMochigoma = '';
    bool sashite = false;
    List<String> boardList = [
      'v香v桂v銀v金v玉v金v銀v桂v香',
      ' ・v飛 ・ ・ ・ ・ ・v角 ・',
      'v歩v歩v歩v歩v歩v歩v歩v歩v歩',
      ' ・ ・ ・ ・ ・ ・ ・ ・ ・',
      ' ・ ・ ・ ・ ・ ・ ・ ・ ・',
      ' ・ ・ ・ ・ ・ ・ ・ ・ ・',
      ' 歩 歩 歩 歩 歩 歩 歩 歩 歩',
      ' ・ 角 ・ ・ ・ ・ ・ 飛 ・',
      ' 香 桂 銀 金 玉 金 銀 桂 香',
    ];

    int turn = 0;
    List<String> moves = [''];
    List<String> memos = [];
    String tempMemo = '';

    for (String line in kif) {
      print(line);
      if (sashite == false) {
        if (line.startsWith('手数----指手')) {
          sashite = true;
        } else if (line.startsWith('後手番')) {
          goteban = true;
        } else if (line.startsWith('先手の持駒')) {
          senteMochigoma = line.substring(6);
        } else if (line.startsWith('後手の持駒')) {
          goteMochigoma = line.substring(6);
        } else if (line.endsWith('|一')) {
          boardList[0] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|二')) {
          boardList[1] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|三')) {
          boardList[2] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|四')) {
          boardList[3] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|五')) {
          boardList[4] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|六')) {
          boardList[5] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|七')) {
          boardList[6] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|八')) {
          boardList[7] = line.substring(1, line.length - 2);
        } else if (line.endsWith('|九')) {
          boardList[8] = line.substring(1, line.length - 2);
        }
      } else {
        if (line.length > 0) {
          if (line.startsWith('*')) {
            tempMemo += '\n' + line.substring(1);
          } else {
            memos.add(tempMemo);
            tempMemo = '';
            moves.add(line);
            turn++;
          }
        }
      }
    }
    memos.add(tempMemo);
    print(memos);
    print(moves);
    print(memos.length);
    print(moves.length);
  }
}

const emptyList = [];

class Kyokumen {
  int turn;
  List<String> board;
  Map<String, int> gotehands = {};
  Map<String, int> sentehands = {};
  String memo = '初期配置の解説です。初手は７６歩か２６歩が多い。７６歩は角道を開ける手で、２６歩は飛車先をついていく手になる。';

  Kyokumen(
      {List<String> board = emptyList,
      String move,
      Kyokumen prevKyokumen,
      String senteHandsStr,
      String goteHandsStr,
      int turn,
      String memo}) {
    if (board != []) {
      this.turn = turn;
      this.memo = memo;
      setInitialBoard(
          board: board,
          senteHandsStr: senteHandsStr,
          goteHandsStr: goteHandsStr);
    }
  }

  void setInitialBoard(
      {List<String> board = emptyList,
      String senteHandsStr,
      String goteHandsStr}) {
    //この表現がわかりやすくて不都合ない
    this.board = board;

    List<String> senteHands = senteHandsStr.split(' ');

    gotehands = {
      '歩': 0,
      '香': 0,
      '桂': 0,
      '銀': 0,
      '金': 0,
      '角': 0,
      '飛': 0,
    };

    sentehands = {
      '歩': 1,
      '香': 2,
      '桂': 3,
      '銀': 4,
      '金': 4,
      '角': 1,
      '飛': 2,
    };

    for (String k in senteHands) {
      String type = k.substring(0, 1);
      String maisuKanji = k.substring(1);
      sentehands[type] = kMaisuKanjiToInt[maisuKanji];
    }
  }

  void setBoard(List<String> board) {}

  void setHands(String senteHands, String goteHands) {}

  void initialBoard1() {
    //この表現がわかりやすくて不都合ない
    board = [
      'v香v桂v銀v金v玉v金v銀v桂v香',
      ' ・v飛 ・ ・ ・ ・ ・v角 ・',
      'v歩v歩v歩v歩v歩v歩v歩v歩v歩',
      ' ・ ・ ・ ・ ・ ・ ・ ・ ・',
      ' ・ ・ ・ ・ ・ ・ ・ ・ ・',
      ' ・ ・ ・ ・ ・ ・ ・ ・ ・',
      ' 歩 歩 歩 歩 歩 歩 歩 歩 歩',
      ' ・ 角 ・ ・ ・ ・ ・ 飛 ・',
      ' 香 桂 銀 金 玉 金 銀 桂 香',
    ];

    gotehands = {
      '歩': 0,
      '香': 0,
      '桂': 0,
      '銀': 0,
      '金': 0,
      '角': 0,
      '飛': 0,
    };

    sentehands = {
      '歩': 1,
      '香': 2,
      '桂': 3,
      '銀': 4,
      '金': 4,
      '角': 1,
      '飛': 2,
    };
  }

  String getMasu(int index) {
    if (index < 0 || 81 <= index) {
      return "誤";
    }

    int dan = index ~/ 9;
    int suji = index % 9;
    //print("$index $suji $dan ${board[dan].length}");
    return board[dan].substring(suji * 2, suji * 2 + 2);
  }
}
