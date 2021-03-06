import 'package:shogi_board/constants.dart';

class Kaisetu {
  List<Kyokumen> tejun = [];
  String title;

  Kaisetu({List<String> kif, String title = 'no title'}) {
    this.title = title;
    bool nextTeban = nextSenteban;
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
    List<Map<String, dynamic>> node = [];
    String tempMemo = "";
    int bunkiIndex = -1;

    bool isHalfwayKyokumen = false; // 初期局面が初期盤面でないか

    for (String line in kif) {
      if (sashite == false) {
        if (line.startsWith('手数----指手')) {
          sashite = true;
          node = [
            {'turn': 0, 'parent': -1, 'children': []}
          ];
        } else if (line.startsWith('後手番')) {
          nextTeban = nextGoteban;
        } else if (line.startsWith('先手の持駒')) {
          senteMochigoma = line.substring(6);
        } else if (line.startsWith('後手の持駒')) {
          goteMochigoma = line.substring(6);
        } else if (line.endsWith('|一')) {
          isHalfwayKyokumen = true;
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
          if (line.startsWith('変化')) {
            bunkiIndex = int.parse(line.substring(3, line.length - 1));
          } else if (line.startsWith('*')) {
            tempMemo += '\n' + line.substring(1);
          } else {
            memos.add(tempMemo);
            tempMemo = '';
            moves.add(line);
            int tesu = int.parse(line.split(' ')[0]);
            if (bunkiIndex == -1) {
              node[node.length - 1]['children'].add(node.length);
              node.add(
                  {'turn': tesu, 'parent': node.length - 1, 'children': []});
            } else {
              for (int i = node.length - 1; i > 0; i--) {
                // 分岐元のchildrenに追加する
                if (node[i]['turn'] == (bunkiIndex - 1)) {
                  node[i]['children'].add(node.length);
                  node.add({'turn': tesu, 'parent': i, 'children': []});
                  break;
                }
              }
              bunkiIndex = -1;
            }
            turn++;
          }
        }
      }
    }

    memos.add(tempMemo);
    // 初期盤面をセットする
    if (isHalfwayKyokumen) {
      tejun.add(Kyokumen(
          isInitailBoard: false,
          board: boardList,
          senteHandsStr: senteMochigoma,
          goteHandsStr: goteMochigoma,
          nextTeban: nextTeban,
          memo: memos[0],
          turn: 0,
          node: node[0]));
    } else {
      // 途中局面でないなら初期配置をセットする
      tejun.add(Kyokumen(
          isInitailBoard: true, memo: memos[0], turn: 0, node: node[0]));
    }
    for (int i = 1; i < moves.length; i++) {
      tejun.add(Kyokumen(
          prevKyokumen: tejun[node[i]['parent']],
          move: moves[i],
          turn: i,
          memo: memos[i],
          node: node[i]));
    }
  }
}

class Kyokumen {
  int _turn;
  List<String> _board; // 盤面
  Map<String, int> _gotehands = {}; // 先手の持駒
  Map<String, int> _sentehands = {}; // 後手の持駒
  String moveStr = ''; // 指し手（この指し手で今の局面になった）
  String sujiDanStr = ''; // 同歩など筋段がわからなくなる場合用に前の局面の値を保持しておく
  bool _nextTeban;
  String memo = '初期配置の解説です。初手は７６歩か２６歩が多い。７６歩は角道を開ける手で、２６歩は飛車先をついていく手になる。';

  // 現在の手数、一手前のインデックス、次の局面のインデックス配列
  // 例: {'turn': 15, 'parent': 14, 'children': [16,24]}
  Map<String, dynamic> node = {};

  bool get nextTeban => _nextTeban;
  int get turn => _turn;
  List<String> get board => _board;
  Map<String, int> get sentehands => _sentehands;
  Map<String, int> get gotehands => _gotehands;

  Kyokumen({
    isInitailBoard = false,
    List<String> board,
    String move,
    Kyokumen prevKyokumen,
    String senteHandsStr,
    String goteHandsStr,
    bool nextTeban,
    int turn,
    String memo,
    Map<String, dynamic> node,
  }) {
    this._turn = turn;
    this.memo = memo == null ? 'なし' : memo;
    this.node = node;

    if (isInitailBoard) {
      initialBoard1();
      return;
    }

    // 局面データある場合
    if (board != null) {
      setInitialBoard(
          board: board,
          senteHandsStr: senteHandsStr,
          goteHandsStr: goteHandsStr,
          nextTeban: nextTeban);
    } else {
      // 指し手とその前の局面がある場合
      setBoardFromMove(prevKyokumen, move);
    }
  }

  List<String> copyList(List<String> l) {
    List<String> tempList = [];
    for (String e in l) {
      tempList.add(e);
    }
    return tempList;
  }

  Map<String, int> copyMap(Map<String, int> m) {
    Map<String, int> tempMap = {};
    m.forEach((String k, int v) {
      tempMap[k] = v;
    });
    return tempMap;
  }

  void setInitialBoard(
      {List<String> board,
      String senteHandsStr,
      String goteHandsStr,
      bool nextTeban = false}) {
    this._board = board;
    this._nextTeban = nextTeban;

    List<String> senteHands = senteHandsStr.split(' ');
    List<String> goteHands = goteHandsStr.split(' ');
    _gotehands = {
      '歩': 0,
      '香': 0,
      '桂': 0,
      '銀': 0,
      '金': 0,
      '角': 0,
      '飛': 0,
    };

    _sentehands = {
      '歩': 0,
      '香': 0,
      '桂': 0,
      '銀': 0,
      '金': 0,
      '角': 0,
      '飛': 0,
    };

    for (String k in senteHands) {
      String type = k.substring(0, 1);
      String maisuKanji = k.substring(1);
      _sentehands[type] = kMaisuKanjiToInt[maisuKanji];
    }

    for (String k in goteHands) {
      String type = k.substring(0, 1);
      String maisuKanji = k.substring(1);
      _gotehands[type] = kMaisuKanjiToInt[maisuKanji];
    }
  }

  /*
  一手前の局面と指し手から局面を生成する。
   */
  void setBoardFromMove(Kyokumen prevKyokumen, String move) {
    //　前回の局面をセット
    this._board = copyList(prevKyokumen.board);
    this._sentehands = copyMap(prevKyokumen.sentehands);
    this._gotehands = copyMap(prevKyokumen.gotehands);
    this._turn = prevKyokumen.turn + 1;
    this._nextTeban = !prevKyokumen.nextTeban;

    List<String> moveList = move.split(' ');
    int tesu = int.parse(moveList[0]);
    String sashite = moveList[1];
    moveStr = sashite;
    sujiDanStr = sashite.substring(0, 2);

    int toSuji = 0;
    int toDan = 0;

    // 同　ooの場合は前局面の指し手も見ないとだめ
    if (sashite.startsWith('同')) {
      sujiDanStr = prevKyokumen.sujiDanStr;
      toSuji = kZenkakuToInt[sujiDanStr.substring(0, 1)];
      toDan = kZenkakuToInt[sujiDanStr.substring(1, 2)];
    } else {
      toSuji = kZenkakuToInt[sashite.substring(0, 1)];
      toDan = kZenkakuToInt[sashite.substring(1, 2)];
    }
    String type = (sashite.substring(2, 3) == '成')
        ? kNarigoma2chrTo1chr[sashite.substring(2, 4)]
        : sashite.substring(2, 3);

    // 駒を取る
    captureKoma(toSuji, toDan);
    if (sashite.endsWith('打')) {
      subHands(type, nextTeban);
    } else {
      int fromSuji =
          int.parse(sashite.substring(sashite.length - 3, sashite.length - 2));
      int fromDan =
          int.parse(sashite.substring(sashite.length - 2, sashite.length - 1));

      putKoma(fromSuji, fromDan, ' ・');
      if (sashite.substring(3, 4) == '成') {
        // 成る
        type = kPromoteType[type];
      }
    }

    String typeWithSengo = nextTeban ? ' ' + type : 'v' + type;
    putKoma(toSuji, toDan, typeWithSengo);
  }

  void putKoma(int suji, int dan, String type) {
    int exchangeStartPos = (9 - suji) * 2;
    String tempDan = _board[(dan - 1)];
    String leftStr = tempDan.substring(0, exchangeStartPos);
    String rightStr = tempDan.substring(exchangeStartPos + 2, 18);
    _board[dan - 1] = leftStr + type + rightStr;
  }

  void captureKoma(int suji, int dan) {
    int exchangeStartPos = (9 - suji) * 2;
    String tempDan = _board[(dan - 1)];
    String captureKoma =
        tempDan.substring(exchangeStartPos, exchangeStartPos + 2);
    String sengo = captureKoma.substring(0, 1);
    String type = captureKoma.substring(1, 2);

    if (captureKoma == ' ・') {
      return;
    } else if (sengo == 'v') {
      _sentehands[kTypeToOriginalType[type]]++;
    } else {
      _gotehands[kTypeToOriginalType[type]]++;
    }
    putKoma(suji, dan, ' ・');
  }

  void addHands(String type, bool sente) {
    if (sente) {
      _sentehands[type]++;
    } else {
      _gotehands[type]++;
    }
  }

  void subHands(String type, bool sente) {
    if (sente) {
      _sentehands[type]--;
    } else {
      _gotehands[type]--;
    }
  }

  void setHands(String senteHands, String goteHands) {}

  void initialBoard1() {
    _nextTeban = nextSenteban;
    //この表現がわかりやすくて不都合ない
    _board = [
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

    _gotehands = {
      '歩': 0,
      '香': 0,
      '桂': 0,
      '銀': 0,
      '金': 0,
      '角': 0,
      '飛': 0,
    };

    _sentehands = {
      '歩': 0,
      '香': 0,
      '桂': 0,
      '銀': 0,
      '金': 0,
      '角': 0,
      '飛': 0,
    };
  }

  String getMasu(int index) {
    if (index < 0 || 81 < index) {
      return "誤";
    }

    int dan = index ~/ 9;
    int suji = index % 9;
    return _board[dan].substring(suji * 2, suji * 2 + 2);
  }
}
