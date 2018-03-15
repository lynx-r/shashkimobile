abstract class Article {
  Article(
      {this.id,
      this.title,
      this.content,
      this.createdAt,
      this.author,
      this.boardBoxId});

  String id;
  String title;
  String content;
  DateTime createdAt;
  String author;
  String boardBoxId;

  String getShortDescription();
}
