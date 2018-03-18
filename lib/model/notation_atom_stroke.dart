import 'package:json_annotation/json_annotation.dart';
import 'package:shashkimobile/model/notation_stroke.dart';

part 'notation_atom_stroke.g.dart';

@JsonSerializable()
class NotationAtomStroke extends Object with _$NotationAtomStrokeSerializerMixin {

  NotationAtomStroke(
      this.type,
      this.strokes,
      this.boardId,
      this.cursor
      );

  String type;
  List<String> strokes;
  String boardId;
  bool cursor;

//  List<List<NotationStroke>> alternative;

  factory NotationAtomStroke.fromJson(Map<String, dynamic> json) => _$NotationAtomStrokeFromJson(json);
}
