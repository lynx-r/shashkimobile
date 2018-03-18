// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notation.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Notation _$NotationFromJson(Map<String, dynamic> json) => new Notation(
    json['whitePlayer'] as String,
    json['blackPlayer'] as String,
    json['event'] as String,
    json['site'] as String,
    json['round'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['result'] as String,
    json['gameType'] as String,
    (json['notationStrokes'] as List)
        ?.map((e) => e == null
            ? null
            : new NotationStroke.fromJson(e as Map<String, dynamic>))
        ?.toList());

abstract class _$NotationSerializerMixin {
  String get whitePlayer;
  String get blackPlayer;
  String get event;
  String get site;
  String get round;
  DateTime get date;
  String get result;
  String get gameType;
  List<NotationStroke> get notationStrokes;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'whitePlayer': whitePlayer,
        'blackPlayer': blackPlayer,
        'event': event,
        'site': site,
        'round': round,
        'date': date?.toIso8601String(),
        'result': result,
        'gameType': gameType,
        'notationStrokes': notationStrokes
      };
}
