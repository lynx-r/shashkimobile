import 'package:json_annotation/json_annotation.dart';
import 'package:shashkimobile/model/board.dart';
import 'package:shashkimobile/model/notation.dart';

part 'board_box.g.dart';

@JsonSerializable()
class BoardBox extends Object with _$BoardBoxSerializerMixin {
  BoardBox(this.id, this.articleId, this.boardId, this.board, this.notation);

  String id;
  String articleId;
  String boardId;
  Board board;
  Notation notation;

  factory BoardBox.fromJson(Map<String, dynamic> json) =>
      _$BoardBoxFromJson(json);
}
