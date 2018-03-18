// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_notation.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

BoardIdNotation _$BoardIdNotationFromJson(Map<String, dynamic> json) =>
    new BoardIdNotation(json['boardId'] as String, json['notation'] as String);

abstract class _$BoardIdNotationSerializerMixin {
  String get boardId;
  String get notation;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'boardId': boardId, 'notation': notation};
}
