import 'dart:async';

import 'dart:io';

retryOnError(Function func, {Function showDialog}) {
  Future future = func();
  var retries = [future];
  Future.wait(retries).catchError((err) {
    print(err);
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
