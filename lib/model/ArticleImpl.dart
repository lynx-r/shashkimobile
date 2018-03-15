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

  @override
  String shortDescription() {
    if (content != null) {
      return content.length > 100 ? content.substring(100) : content;
    } else {
      return '';
    }
  }

  factory ArticleImpl.fromJsonString(string) {
    return new JsonDecoder().convert(string);
  }

  factory ArticleImpl.fromMap(map) {
    var article = new ArticleImpl();
    article.author = map['author'];
    article.boardBoxId = map['boardBoxId'];
    article.content = map['content'];
    article.createdAt = new DateTime.fromMillisecondsSinceEpoch(map['createdAt'], isUtc: true);
    article.id = map['id'];
    article.title = map['title'];
    return article;
  }
}
