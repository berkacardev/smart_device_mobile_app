import 'package:flutter_svg/flutter_svg.dart';

abstract class IconConstants{
  static SvgPicture get toolsIcon => _getSvgPicture("tools");
  static SvgPicture get addIcon => _getSvgPicture("add");



  static const String smartDevicesIconPath = "smart_devices";
  static const String smartDustbinIconPath = "smart_dustbin";
  static const String smileEmojiIconPath = "smile_emoji";
  static const String sadEmojiIconPath = "sad_emoji";

  static String _toSvg(String name) {
    return "assets/icons/$name.svg";
  }
  static SvgPicture _getSvgPicture(String name) {
    return SvgPicture.asset(_toSvg(name));
  }
}