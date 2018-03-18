import 'package:flutter/material.dart';
import 'package:shashkimobile/page/detail_page.dart';
import 'package:shashkimobile/page/explore_page.dart';

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
      onGenerateRoute: (RouteSettings settings) {
        var path = settings.name.split('/');
        if (path[0].startsWith('details')) {
          if (path[1] != null) {
            return new MaterialPageRoute(
              builder: (context) =>
              new DetailPage(path[1], title: 'Подробности'),
              settings: settings,
            );
          }
        }
      },
    );
  }
}
