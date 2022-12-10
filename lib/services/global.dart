import 'package:flutter/material.dart';

class MyClass {
  static final listIndex = ValueNotifier<int>(0);
  static var firstLoad = true;
  static var dismissedSong = true;
  static final isSelected = ValueNotifier<bool>(false);
}
