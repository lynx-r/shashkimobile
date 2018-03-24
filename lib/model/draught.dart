import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'draught.g.dart';

@JsonSerializable()
class Draught extends Object with _$DraughtSerializerMixin {

  Draught(
      this.black,
      this.queen,
      this.captured,
      this.markCaptured,
      this.v,
      this.h,
      this.highlighted
      );

  bool black;
  bool queen;
  bool captured;
  bool markCaptured;
  int v;
  int h;
  bool highlighted;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Draught &&
              runtimeType == other.runtimeType &&
              v == other.v &&
              h == other.h;

  @override
  int get hashCode =>
      v.hashCode ^
      h.hashCode;

  @override
  String toString() {
    return JSON.encode(toJson());
  }

  factory Draught.fromJson(Map<String, dynamic> json) => _$DraughtFromJson(json);
}
