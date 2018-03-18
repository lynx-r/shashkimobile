// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draught.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Draught _$DraughtFromJson(Map<String, dynamic> json) => new Draught(
    json['black'] as bool,
    json['queen'] as bool,
    json['captured'] as bool,
    json['markCaptured'] as bool,
    json['v'] as int,
    json['h'] as int,
    json['highlighted'] as bool);

abstract class _$DraughtSerializerMixin {
  bool get black;
  bool get queen;
  bool get captured;
  bool get markCaptured;
  int get v;
  int get h;
  bool get highlighted;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'black': black,
        'queen': queen,
        'captured': captured,
        'markCaptured': markCaptured,
        'v': v,
        'h': h,
        'highlighted': highlighted
      };
}
