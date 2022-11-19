import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int color) {
    return Color(color);
  }

  @override
  int toJson(Color color) => color.value;
}
