import 'package:flutter/material.dart';

Color khandsColor = Color(0xFFd67c00);
Color kBoardColor = Color(0xFFf2c077);
Color kKeisenColor = Color(0xFF79603b);

const kMaisuKanjiToInt = {
  '一': 1,
  '二': 2,
  '三': 3,
  '四': 4,
  '五': 5,
  '六': 6,
  '七': 7,
  '八': 8,
  '九': 9,
  '十': 10,
  '十一': 11,
  '十二': 12,
  '十三': 13,
  '十四': 14,
  '十五': 15,
  '十六': 16,
  '十七': 17,
  '十八': 18,
};

const kZenkakuToInt = {
  '一': 1,
  '二': 2,
  '三': 3,
  '四': 4,
  '五': 5,
  '六': 6,
  '七': 7,
  '八': 8,
  '九': 9,
  '１': 1,
  '２': 2,
  '３': 3,
  '４': 4,
  '５': 5,
  '６': 6,
  '７': 7,
  '８': 8,
  '９': 9,
};

const kNarigoma2chrTo1chr = {
  '成香': '杏',
  '成桂': '圭',
  '成銀': '全',
};

const kPromoteType = {
  '歩': 'と',
  '香': '杏',
  '桂': '圭',
  '銀': '全',
  '角': '馬',
  '飛': '龍',
};

const kTypeToOriginalType = {
  '歩': '歩',
  '香': '香',
  '桂': '桂',
  '銀': '銀',
  '金': '金',
  '角': '角',
  '飛': '飛',
  'と': '歩',
  '杏': '香',
  '圭': '桂',
  '全': '銀',
  '馬': '角',
  '龍': '飛',
};

const kHandsOrder = ['飛', '角', '金', '銀', '桂', '香', '歩'];
