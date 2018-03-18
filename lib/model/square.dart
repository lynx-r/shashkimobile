import 'package:shashkimobile/model/draught.dart';

import 'package:json_annotation/json_annotation.dart';

part 'square.g.dart';

@JsonSerializable()
class Square {
  Square(
      this.v,
      this.h,
      this.main,
      this.highlighted,
      this.occupied,
      this.draught,
      this.size,
      this.notation
      );

  int v;
  int h;
  bool main;
  bool highlighted;
  bool occupied;
  Draught draught;
  int size;
  String notation;

  factory Square.fromJson(Map<String, dynamic> json) => _$SquareFromJson(json);
}
