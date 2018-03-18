// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notation_atom_stroke.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

NotationAtomStroke _$NotationAtomStrokeFromJson(Map<String, dynamic> json) =>
    new NotationAtomStroke(
        json['type'] as String,
        (json['strokes'] as List)?.map((e) => e as String)?.toList(),
        json['boardId'] as String,
        json['cursor'] as bool);

abstract class _$NotationAtomStrokeSerializerMixin {
  String get type;
  List<String> get strokes;
  String get boardId;
  bool get cursor;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'strokes': strokes,
        'boardId': boardId,
        'cursor': cursor
      };
}
