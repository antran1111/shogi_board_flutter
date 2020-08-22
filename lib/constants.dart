import 'package:flutter/material.dart';

Color khandsColor = Color(0xFFd67c00);
Color kBoardColor = Color(0xFFf2c077);
Color kKeisenColor = Color(0xFF79603b);

// その局面の次の手番が先手か後手か
const nextSenteban = false;
const nextGoteban = true;

const kCellBorderSide = BorderSide(color: Colors.black, width: 0.6);

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

const kKifPieceToImageFilename = {
  ' ・': 'assets/images/empty.svg',
  ' 歩': 'assets/images/s_fu.svg',
  ' 香': 'assets/images/s_kyo.svg',
  ' 桂': 'assets/images/s_kei.svg',
  ' 銀': 'assets/images/s_gin.svg',
  ' 金': 'assets/images/s_kin.svg',
  ' 角': 'assets/images/s_kaku.svg',
  ' 飛': 'assets/images/s_hi.svg',
  ' 玉': 'assets/images/s_gyoku.svg',
  ' と': 'assets/images/s_to.svg',
  ' 杏': 'assets/images/s_narikyo.svg',
  ' 圭': 'assets/images/s_narikei.svg',
  ' 全': 'assets/images/s_narigin.svg',
  ' 馬': 'assets/images/s_uma.svg',
  ' 龍': 'assets/images/s_ryu.svg',
  'v歩': 'assets/images/g_fu.svg',
  'v香': 'assets/images/g_kyo.svg',
  'v桂': 'assets/images/g_kei.svg',
  'v銀': 'assets/images/g_gin.svg',
  'v金': 'assets/images/g_kin.svg',
  'v角': 'assets/images/g_kaku.svg',
  'v飛': 'assets/images/g_hi.svg',
  'v玉': 'assets/images/g_gyoku.svg',
  'vと': 'assets/images/g_to.svg',
  'v杏': 'assets/images/g_narikyo.svg',
  'v圭': 'assets/images/g_narikei.svg',
  'v全': 'assets/images/g_narigin.svg',
  'v馬': 'assets/images/g_uma.svg',
  'v龍': 'assets/images/g_ryu.svg',
};

const kHandsOrder = ['飛', '角', '金', '銀', '桂', '香', '歩'];

const kSenteHandsOrderToSVG = [' 飛', ' 角', ' 金', ' 銀', ' 桂', ' 香', ' 歩'];
const kGoteHandsOrderToSVG = ['v飛', 'v角', 'v金', 'v銀', 'v桂', 'v香', 'v歩'];
