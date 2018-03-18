import 'package:shashkimobile/model/board_notation.dart';
import 'package:shashkimobile/model/rules.dart';
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
      this.rules,
      this.black,
      this.blackTurn,
      this.strokeNumber,
      this.stroke,
      this.notation);

  String id;
  List<Square> squares;
  Square selectedSquare;
  Square nextSquare;
  List<BoardIdNotation> previousBoards;
  List<BoardIdNotation> nextBoards;
  String rules;
  bool black;
  bool blackTurn;
  int strokeNumber;
  String stroke;
  String notation;

  factory Board.fromJson(Map<String, dynamic> json) => _$BoardFromJson(json);
}
