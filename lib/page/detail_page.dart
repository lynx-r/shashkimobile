import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shashkimobile/model/article.dart';
import 'package:shashkimobile/model/board_box.dart';
import 'package:shashkimobile/utils/custom_http_clent.dart';
import 'package:shashkimobile/utils/utils.dart';
import 'package:shashkimobile/widget/board_painter.dart';

class DetailPage extends StatefulWidget {
  DetailPage(this._articleId, {Key key, this.title}) : super(key: key);

  final String _articleId;
  final String title;

  @override
  State<StatefulWidget> createState() => new _DetailPageState(_articleId);
}

class _DetailPageState extends State<DetailPage> {
  ui.Offset _paintDownOffset;

  _DetailPageState(this._articleId);

  GlobalKey _paintKey = new GlobalKey();
  CustomPaint _canvas;
  BoardPainter _boardPainter;

  Map<String, ui.Image> _images = {};
  List<String> _imagesNames = [
    'black_draught',
    'white_draught',
    'black_queen',
    'white_queen'
  ];
  var _httpClient = new CustomHttpClient();
  final String _articleId;
  Article _article;
  BoardBox _boardBox;
  AppBar _appBar;

  @override
  void initState() {
    super.initState();
    retryOnError(_fetchArticle);
    _loadImagesInState();
  }

  @override
  Widget build(BuildContext context) {
//    _touch = new GestureDetector(
//      onPanStart: _panDown,
//    );

    _boardPainter = new BoardPainter(_paintDownOffset, _boardBox, _images);

    _canvas = new CustomPaint(
      key: _paintKey,
      painter: _boardPainter,
      child: new ConstrainedBox(
        constraints: new BoxConstraints.expand(),
      ),
    );

    var canvasListener = new Listener(
      onPointerDown: (PointerDownEvent event) {
        RenderBox referenceBox = _paintKey.currentContext.findRenderObject();
        Offset offset = referenceBox.globalToLocal(event.position);
        setState(() {
          _paintDownOffset = offset;
        });
      },
      child: _canvas,
    );

    var mainTab = new Container(
        child: new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      new Flexible(fit: FlexFit.loose, child: canvasListener),
      new Flexible(fit: FlexFit.loose, child: new Text('123'))
    ]));

    _appBar = new AppBar(
      bottom: new TabBar(
        tabs: [
          new Tab(icon: new Icon(Icons.play_arrow)),
          new Tab(icon: new Icon(Icons.directions_transit)),
          new Tab(icon: new Icon(Icons.directions_bike)),
        ],
      ),
      title: new Text('Игра'),
    );

    var tabController = new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: _appBar,
          body: new TabBarView(
            children: [
              mainTab,
              new Icon(Icons.directions_transit),
              new Icon(Icons.directions_bike),
            ],
          ),
        ));

    return tabController;
  }

  _fetchArticle() async {
    var artcileUrl =
        'https://hzvzddncfb.execute-api.eu-west-1.amazonaws.com/dev/api/v1';
    var boardUrl =
        'https://8vc9rklqxh.execute-api.eu-west-1.amazonaws.com/dev/api/v1';
    var uri = '$artcileUrl/article/$_articleId';
    print('FETCH ARTICLE $uri');
    var response = await _httpClient.getUrl(Uri.parse(uri));
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      var decoded = JSON.decode(json);
      var body = decoded['body'] as Map;

      setState(() {
        _article = new Article.fromJson(body);
      });

      var boardBoxId = body['boardBoxId'];

      print('BOARD_BOX_ID $boardBoxId');

      uri = '$boardUrl/board/$boardBoxId';
      print('FETCH BOARD_BOX: $uri');
      response = await _httpClient.getUrl(Uri.parse(uri));
      if (response.statusCode == HttpStatus.OK) {
        json = await response.transform(UTF8.decoder).join();
        decoded = JSON.decode(json);
        body = decoded['body'] as Map;
        setState(() {
          _boardBox = new BoardBox.fromJson(body);
          print('BOARD_BOX $_boardBox');
        });
      }
    } else {
      throw new Exception('HttpError status code: $response.statusCode');
    }
  }

  void _loadImagesInState() async {
    Map<String, ui.Image> images = {};
    Future.forEach(_imagesNames, (name) {
      return _loadImages(name).then((image) {
        print(image);
        if (image != null) {
          images.addAll(image);
        }
      });
    }).whenComplete(() {
      print(images);

      setState(() {
        _images = new HashMap.from(images);
      });
    });
  }

  Future<Map<String, ui.Image>> _loadImages(name) async {
    Completer<Map<String, ui.Image>> completer = new Completer();
    var bytes;
    try {
      bytes = await DefaultAssetBundle.of(context).load('images/$name.png');
    } catch (e) {
      print(e);
      return new Future.sync(() => null);
    }
    var imageProvider = new MemoryImage(bytes.buffer.asUint8List());
    var configuration = new ImageConfiguration();
    var imageStream = imageProvider.resolve(configuration);
    imageStream.addListener((imageInfo, sync) {
      completer.complete({name: imageInfo.image});
    });
    return completer.future;
  }
}
