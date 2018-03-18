// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notation_stroke.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

NotationStroke _$NotationStrokeFromJson(Map<String, dynamic> json) =>
    new NotationStroke(
        json['count'] as int,
        json['first'] == null
            ? null
            : new NotationAtomStroke.fromJson(
                json['first'] as Map<String, dynamic>),
        json['second'] == null
            ? null
            : new NotationAtomStroke.fromJson(
                json['second'] as Map<String, dynamic>));

abstract class _$NotationStrokeSerializerMixin {
  int get count;
  NotationAtomStroke get first;
  NotationAtomStroke get second;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'count': count, 'first': first, 'second': second};
}
