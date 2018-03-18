// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Board _$BoardFromJson(Map<String, dynamic> json) => new Board(
    json['id'] as String,
    (json['squares'] as List)
        ?.map((e) =>
            e == null ? null : new Square.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['selectedSquare'] == null
        ? null
        : new Square.fromJson(json['selectedSquare'] as Map<String, dynamic>),
    json['nextSquare'] == null
        ? null
        : new Square.fromJson(json['nextSquare'] as Map<String, dynamic>),
    (json['previousBoards'] as List)
        ?.map((e) => e == null
            ? null
            : new BoardIdNotation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['nextBoards'] as List)
        ?.map((e) => e == null
            ? null
            : new BoardIdNotation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['rules'] as String,
    json['black'] as bool,
    json['blackTurn'] as bool,
    json['strokeNumber'] as int,
    json['stroke'] as String,
    json['notation'] as String);

abstract class _$BoardSerializerMixin {
  String get id;
  List<Square> get squares;
  Square get selectedSquare;
  Square get nextSquare;
  List<BoardIdNotation> get previousBoards;
  List<BoardIdNotation> get nextBoards;
  String get rules;
  bool get black;
  bool get blackTurn;
  int get strokeNumber;
  String get stroke;
  String get notation;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'squares': squares,
        'selectedSquare': selectedSquare,
        'nextSquare': nextSquare,
        'previousBoards': previousBoards,
        'nextBoards': nextBoards,
        'rules': rules,
        'black': black,
        'blackTurn': blackTurn,
        'strokeNumber': strokeNumber,
        'stroke': stroke,
        'notation': notation
      };
}
