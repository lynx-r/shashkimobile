// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => new Article(
    json['id'] as String,
    json['title'] as String,
    json['content'] as String,
    json['author'] as String,
    json['boardBoxId'] as String);

abstract class _$ArticleSerializerMixin {
  String get id;
  String get title;
  String get content;
  String get author;
  String get boardBoxId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
        'author': author,
        'boardBoxId': boardBoxId
      };
}
