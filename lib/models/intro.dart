import 'package:json_annotation/json_annotation.dart';

part 'intro.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Intro {
  final String title;
  final String text;
  final String image;

  const Intro(this.title, this.text, this.image);

  factory Intro.fromJson(Map<String, dynamic> json) => _$IntroFromJson(json);

  Map<String, dynamic> toJson() => _$IntroToJson(this);
}
