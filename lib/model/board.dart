import 'dart:convert';

import 'package:shashkimobile/model/board_notation.dart';
import 'package:shashkimobile/model/draught.dart';
import 'package:shashkimobile/model/square.dart';

import 'package:json_annotation/json_annotation.dart';

part 'board.g.dart';

@JsonSerializable()
class Board extends Object with _$BoardSerializerMixin {
  Board(this.id,
      this.squares,
      this.selectedSquare,
      this.nextSquare,
      this.previousBoards,
      this.nextBoards,
      this.whiteDraughts,
      this.blackDraughts,
      this.rules,
      this.black,
      this.strokeCount,
      this.blackTurn);

  String id;
  List<Square> squares;
  Square selectedSquare;
  Square nextSquare;
  List<BoardIdNotation> previousBoards;
  List<BoardIdNotation> nextBoards;
  String rules;
  bool black;
  bool blackTurn;
  int strokeCount;
  Map<String, Draught> whiteDraughts;
  Map<String, Draught> blackDraughts;
  int createdAt;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);

  @override
  String toString() {
    return JSON.encode(toJson());
  }
}
