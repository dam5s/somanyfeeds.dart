import 'package:damo_io_server/prelude/result.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'http_error.dart';

enum HttpMethod {
  get;

  @override
  String toString() => switch (this) {
        get => 'GET',
      };
}

typedef HttpResult<T> = Result<T, HttpError>;
typedef HttpFuture<T> = Future<HttpResult<T>>;

extension SendRequest on Client {
  HttpFuture<Response> sendRequest(HttpMethod method, Uri url) async {
    try {
      final request = Request(method.toString(), url);
      final streamedResponse = await send(request);
      final response = await Response.fromStream(streamedResponse);

      return Ok(response);
    } on Exception catch (e) {
      _logger.w("Exception during request $method $url", error: e);
      return Err(HttpConnectionError(e));
    }
  }
}

extension ResponseHandling on HttpResult<Response> {
  HttpResult<Response> expectStatusCode(int expected) => flatMapOk((response) {
        if (response.statusCode == expected) {
          return Ok(response);
        } else {
          _logger.w("Unexpected status code, expected $expected, got ${response.statusCode}");
          return Err(HttpUnexpectedStatusCodeError(expected, response.statusCode));
        }
      });
}

final _logger = Logger();
