import 'package:flutter/material.dart';

class SettingServices {
  static List<BoxShadow> mainShadow = [
    BoxShadow(
      color: Colors.black12.withOpacity(0.1),
      blurRadius: 7,
      offset: const Offset(0, -2),
    ),
    BoxShadow(
      color: Colors.black12.withOpacity(0.1),
      blurRadius: 7,
      offset: const Offset(0, 2),
    ),
  ];
}
