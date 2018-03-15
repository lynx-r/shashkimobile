import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shashkimobile/model/Article.dart';
import 'package:shashkimobile/model/ArticleImpl.dart';
import 'package:shashkimobile/utils/CustomHttpClent.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ШашкиОнлайн',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new ExplorePage(title: 'ShashkipediA'),
    );
  }
}

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ExplorePageState createState() => new _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var _httpClient = new CustomHttpClient();
  var _articleCards = new List<Widget>();
  var _articles = new List<Article>();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  bool _refreshList(notification) {
    _fetchArticles(notification);
    return true;
  }

  _fetchArticles(notification) async {
    if (notification is ScrollEndNotification || notification == null) {
      print('1');
      var url =
          'https://hzvzddncfb.execute-api.eu-west-1.amazonaws.com/dev/api/v1';
      var response =
          await _httpClient.getUrl(Uri.parse('$url/articles?limit=20'));
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var decoded = JSON.decode(json);
        var body = decoded['body'] as List;
        _articles.clear();
        body.forEach((article) {
          _articles.add(new ArticleImpl.fromMap(article));
        });

        setState(() {
          _articleCards.clear();
          _articles.forEach((article) {
            _articleCards.add(new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                      title: new Text(article.title),
                      subtitle: new Text(article.shortDescription()))
                ],
              ),
            ));
          });
        });
      } else {
        throw new Exception('HttpError status code: $response.statusCode');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchArticles(null);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    print('CARDS ' + _articleCards.toString());
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
        leading:
            new IconButton(icon: new Icon(Icons.settings), onPressed: null),
      ),
      body: new Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new NotificationListener(
              onNotification: _refreshList,
              child: new ListView(
                padding: new EdgeInsets.all(8.0),
                itemExtent: 20.0,
                children: _articleCards,
              ))),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
