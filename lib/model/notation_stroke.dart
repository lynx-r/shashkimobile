import 'package:json_annotation/json_annotation.dart';
import 'package:shashkimobile/model/notation_atom_stroke.dart';

part 'notation_stroke.g.dart';

@JsonSerializable()
class NotationStroke extends Object with _$NotationStrokeSerializerMixin {

  NotationStroke(
      this.count,
      this.first,
      this.second
      );

  int count;
  NotationAtomStroke first;
  NotationAtomStroke second;

  factory NotationStroke.fromJson(Map<String, dynamic> json) => _$NotationStrokeFromJson(json);
}
