import 'dart:async';
import 'dart:io';

class CustomHttpClient {
  var _httpClient = new HttpClient();

  void close({bool force: false}) {
    _httpClient.close(force: force);
  }

  Future<HttpClientResponse> delete(String host, int port, String path) {
    return _httpClient.delete(host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> deleteUrl(Uri url) {
    return _httpClient.deleteUrl(url).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> get(String host, int port, String path) {
    return _httpClient.get(host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> getUrl(Uri url) {
    return _httpClient.getUrl(url).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> head(String host, int port, String path) {
    return _httpClient.head(host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> headUrl(Uri url) {
    return _httpClient.headUrl(url).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> open(
      String method, String host, int port, String path) {
    return _httpClient.open(method, host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> openUrl(String method, Uri url) {
    return _httpClient.openUrl(method, url).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> patch(String host, int port, String path) {
    return _httpClient.patch(host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> patchUrl(Uri url) {
    return _httpClient.patchUrl(url).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> post(String host, int port, String path) {
    return _httpClient.post(host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> postUrl(Uri url, String json) {
    return _httpClient.postUrl(url).then((request) {
      _configRequest(request);
      request.write(json);
      return request.close();
    });
  }

  Future<HttpClientResponse> put(String host, int port, String path) {
    return _httpClient.put(host, port, path).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  Future<HttpClientResponse> putUrl(Uri url) {
    return _httpClient.putUrl(url).then((request) {
      _configRequest(request);
      return request.close();
    });
  }

  void _configRequest(HttpClientRequest request) {
    request.headers.add('Content-Type', 'text/json');
  }
}
