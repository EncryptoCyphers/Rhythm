import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Color veryLightPurple = const Color.fromARGB(255, 116, 92, 201);

Color bgPurple = const Color.fromARGB(255, 179, 151, 255);

Color fgPurple = const Color.fromARGB(255, 82, 46, 145);

Color shimmerBackGround = const Color.fromARGB(255, 214, 214, 214);

Color shimmerHighLight = const Color.fromARGB(255, 255, 255, 255);

var repeatOne = Image.asset('svg/repeat-one-line.svg');
