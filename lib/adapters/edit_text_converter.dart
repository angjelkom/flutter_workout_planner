import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class TextEditConverter
    implements JsonConverter<TextEditingController, String> {
  const TextEditConverter();

  @override
  TextEditingController fromJson(String text) {
    return TextEditingController(text: text);
  }

  @override
  String toJson(TextEditingController controller) => controller.text;
}
