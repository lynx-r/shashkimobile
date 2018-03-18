// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_box.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

BoardBox _$BoardBoxFromJson(Map<String, dynamic> json) => new BoardBox(
    json['id'] as String,
    json['articleId'] as String,
    json['boardId'] as String,
    json['board'] == null
        ? null
        : new Board.fromJson(json['board'] as Map<String, dynamic>),
    json['notation'] == null
        ? null
        : new Notation.fromJson(json['notation'] as Map<String, dynamic>));

abstract class _$BoardBoxSerializerMixin {
  String get id;
  String get articleId;
  String get boardId;
  Board get board;
  Notation get notation;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'articleId': articleId,
        'boardId': boardId,
        'board': board,
        'notation': notation
      };
}
