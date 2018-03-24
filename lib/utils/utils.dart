import 'dart:async';
import 'dart:developer';

import 'dart:io';

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
