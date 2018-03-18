import 'package:json_annotation/json_annotation.dart';

part 'board_notation.g.dart';

@JsonSerializable()
class BoardIdNotation extends Object with _$BoardIdNotationSerializerMixin {
  BoardIdNotation(this.boardId, this.notation);

  String boardId;
  String notation;

  factory BoardIdNotation.fromJson(Map<String, dynamic> json) =>
      _$BoardIdNotationFromJson(json);
}
