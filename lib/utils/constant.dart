import 'package:flutter/material.dart';

class ColorUI {
  static const Color PRIMARY = Color(0xFF252E4B);
  static const Color SECONDARY = Color(0xFFF26322);
  static const Color GREEN = Color(0xFF00B75B);
  static const Color RED = Color(0xFFFF0000);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLACK = Color(0xFF000000);
  static const Color GREY = Color(0xFFD0D0D0);
  static const Color TEXT = Color(0xFF333232);
  static const Color TEXT_HINT = Color(0xFFB8B8B8);
  static const Color DISABLED_BUTTON = Color.fromARGB(255, 199, 198, 198);
  static const Color PINK = Color(0xFFFE697A);
}

class FontUI {
  static const FontWeight WEIGHT_LIGHT = FontWeight.w300;
  static const FontWeight WEIGHT_SEMI_LIGHT = FontWeight.w400;
  static const FontWeight WEIGHT_NORMAL = FontWeight.w500;
  static const FontWeight WEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight WEIGHT_BOLD = FontWeight.w700;
}

const TextStyle TEXT_STYLE = TextStyle(color: ColorUI.TEXT);
const TextStyle BLACK_TEXT_STYLE = TextStyle(color: ColorUI.BLACK);
const TextStyle HINT_TEXT_STYLE = TextStyle(color: ColorUI.TEXT_HINT);
const TextStyle PINK_TEXT_STYLE = TextStyle(color: ColorUI.PINK);
const TextStyle WHITE_TEXT_STYLE = TextStyle(color: ColorUI.WHITE);
const TextStyle CARD_TEXT = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 14,
);

class API {
  static const String emulatorIos = 'http://localhost:3000';
  static const String emulatorAndroid = 'http://10.0.2.2:3000';

  ///NOTE: HOST PHYSICAL DEVICE IF YOU SHOW IN DEVICE PHYSICAL ADJUST WITH IPCONFIG ON LAPTOP
  static const String physicalDevice = 'http://10.2.13.158';
}
