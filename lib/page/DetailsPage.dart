import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shashkimobile/model/Article.dart';
import 'package:shashkimobile/model/ArticleImpl.dart';
import 'package:shashkimobile/utils/CustomHttpClent.dart';

class DetailsPage extends StatefulWidget {

  DetailsPage(this._articleId, {Key key, this.title}): super(key: key);

  final String _articleId;
  final String title;

  @override
  State<StatefulWidget> createState() => new _DetailsPageState(_articleId);
}

class _DetailsPageState extends State<DetailsPage> {

  _DetailsPageState(this._articleId);

  var _httpClient = new CustomHttpClient();
  final String _articleId;
  Article _article;

  @override
  void initState() {
    super.initState();
    _fetchArticle();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Text('details for ${_article == null ? '' : _article.title}'),
      ),
    );
  }

  _fetchArticle() async {
    var url =
        'https://hzvzddncfb.execute-api.eu-west-1.amazonaws.com/dev/api/v1';
    var uri = '$url/article/$_articleId';
    print(uri);
    var response = await _httpClient.getUrl(Uri.parse(uri));
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      var decoded = JSON.decode(json);
      var body = decoded['body'] as Map;
      setState(() {
        _article = new ArticleImpl.fromMap(body);
      });
    } else {
      throw new Exception('HttpError status code: $response.statusCode');
    }
  }
}
