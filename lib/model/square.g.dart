// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'square.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Square _$SquareFromJson(Map<String, dynamic> json) => new Square(
    json['v'] as int,
    json['h'] as int,
    json['main'] as bool,
    json['highlighted'] as bool,
    json['occupied'] as bool,
    json['draught'] == null
        ? null
        : new Draught.fromJson(json['draught'] as Map<String, dynamic>),
    json['size'] as int,
    json['notation'] as String);

abstract class _$SquareSerializerMixin {
  int get v;
  int get h;
  bool get main;
  bool get highlighted;
  bool get occupied;
  Draught get draught;
  int get size;
  String get notation;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'v': v,
        'h': h,
        'main': main,
        'highlighted': highlighted,
        'occupied': occupied,
        'draught': draught,
        'size': size,
        'notation': notation
      };
}
