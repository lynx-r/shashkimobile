import 'dart:convert';

import 'package:shashkimobile/model/Article.dart';

class ArticleImpl implements Article {
  ArticleImpl();

  @override
  String author;

  @override
  String boardBoxId;

  @override
  String content;

  @override
  DateTime createdAt;

  @override
  String id;

  @override
  String title;

  factory ArticleImpl.fromJsonString(string) {
    return new JsonDecoder().convert(string);
  }
}
