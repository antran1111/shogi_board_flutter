class Kaisetu {
  List<Kyokumen> Tejun;

  Kaisetu() {
    Tejun = [
      Kyokumen(),
      Kyokumen(),
    ];
  }
}

class Kyokumen {
  int tesu;
  List<String> board;
  Map<String, int> gotehands = {};
  Map<String, int> sentehands = {};
  String memo = '初期配置の解説です。初手は７６歩か２６歩が多い。７６歩は角道を開ける手で、２６歩は飛車先をついていく手になる。';

  Kyokumen() {
    initialBoard();
  }

  void initialBoard() {
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
    if (index < 0 || 81 <= index) {
      return "誤";
    }

    int dan = index ~/ 9;
    int suji = index % 9;
    print("$index $suji $dan ${board[dan].length}");
    return board[dan].substring(suji * 2, suji * 2 + 2);
  }
}
