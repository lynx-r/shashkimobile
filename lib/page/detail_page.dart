import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shashkimobile/model/article.dart';
import 'package:shashkimobile/model/board_box.dart';
import 'package:shashkimobile/utils/CustomHttpClent.dart';
import 'package:shashkimobile/widget/board_painter.dart';

class DetailPage extends StatefulWidget {
  DetailPage(this._articleId, {Key key, this.title}) : super(key: key);

  final String _articleId;
  final String title;

  @override
  State<StatefulWidget> createState() => new _DetailPageState(_articleId);
}

class _DetailPageState extends State<DetailPage> {
  _DetailPageState(this._articleId);

  var _httpClient = new CustomHttpClient();
  final String _articleId;
  Article _article;
  AnimationController _controller;

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
          child: new CustomPaint(
        painter: new BoardPainter(),
        child: new Center(),
      )),
    );
  }

  _fetchArticle() async {
    var artcileUrl =
        'https://hzvzddncfb.execute-api.eu-west-1.amazonaws.com/dev/api/v1';
    var boardUrl =
        'https://8vc9rklqxh.execute-api.eu-west-1.amazonaws.com/dev/api/v1';
    var uri = '$artcileUrl/article/$_articleId';
    print(uri);
    var response = await _httpClient.getUrl(Uri.parse(uri));
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      var decoded = JSON.decode(json);
      var body = decoded['body'] as Map;

      setState(() {
        _article = new Article.fromJson(body);
      });

      var boardBoxId = body['boardBoxId'];
      print(boardBoxId);
      uri = '$boardUrl/board/$boardBoxId';
      response = await _httpClient.getUrl(Uri.parse(uri));
      if (response.statusCode == HttpStatus.OK) {
        json = await response.transform(UTF8.decoder).join();
        decoded = JSON.decode(json);
        body = decoded['body'] as Map;
        print(body);
        var boardBox = new BoardBox.fromJson(body);
        print(boardBox.board.toJson());
      }
    } else {
      throw new Exception('HttpError status code: $response.statusCode');
    }
  }
}
