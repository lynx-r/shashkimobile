import 'dart:convert';

import 'package:shashkimobile/model/draught.dart';

import 'package:json_annotation/json_annotation.dart';

part 'square.g.dart';

@JsonSerializable()
class Square extends Object with _$SquareSerializerMixin {
  Square(this.v, this.h, this.main, this.highlighted, this.occupied,
      this.draught, this.notation);

  int v;
  int h;
  bool main;
  bool highlighted;
  bool occupied;
  Draught draught;
  String notation;

  factory Square.fromJson(Map<String, dynamic> json) => _$SquareFromJson(json);

  @override
  String toString() {
    return JSON.encode(toJson());
  }
}
