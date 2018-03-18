import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article extends Object with _$ArticleSerializerMixin {
  Article(this.id, this.title, this.content/*, this.createdAt*/, this.author,
      this.boardBoxId);

  String id;
  String title;
  String content;
//  DateTime createdAt;
  String author;
  String boardBoxId;

  String getShortDescription() {
    return content != null ? content : '';
  }

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
