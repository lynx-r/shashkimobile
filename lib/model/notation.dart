import 'package:json_annotation/json_annotation.dart';
import 'package:shashkimobile/model/notation_stroke.dart';

part 'notation.g.dart';

@JsonSerializable()
class Notation extends Object with _$NotationSerializerMixin {

  Notation(
      this.whitePlayer,
      this.blackPlayer,
      this.event,
      this.site,
      this.round,
      this.date,
      this.result,
      this.gameType,
      this.notationStrokes
      );

  String whitePlayer;
  String blackPlayer;
  String event;
  String site;
  String round;
  DateTime date;
  String result;
  String gameType;

  List<NotationStroke> notationStrokes;

  factory Notation.fromJson(Map<String, dynamic> json) => _$NotationFromJson(json);
}
