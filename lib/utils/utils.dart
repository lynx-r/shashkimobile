import 'dart:async';
import 'dart:developer';

import 'dart:io';

import 'package:flutter/material.dart';

retryOnError(Function func, {Function showDialog}) async {
  Future future = func();
  var retries = [future];
  Future.wait(retries).catchError((dynamic err, StackTrace trace) {
    print('EXCEPTION: ${err.toString()}');
    print('TRACE: $trace');
    if (showDialog != null) {
      showDialog().then((confirm) {
        if (confirm) retryOnError(func, showDialog: showDialog);
      });
    } else {
      sleep(new Duration(seconds: 2));
      retryOnError(func);
    }
  });
}

Future<bool> showRetryNetworkConnectionDialog(context) {
  return showDialog(
      context: context,
      child: new SimpleDialog(
        title: const Text('Ошибка соединения'),
        children: <Widget>[
          new SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: new Text('Повторить попытку?')),
          new SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: new Text('Отмена'))
        ],
      ));
}
