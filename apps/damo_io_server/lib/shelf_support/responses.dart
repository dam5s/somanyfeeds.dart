import 'dart:io';

import 'package:shelf/shelf.dart';

abstract class Responses {
  static Response redirect(String location) =>
      Response(HttpStatus.found, headers: {'location': location});

  static Response badRequest() => Response(HttpStatus.badRequest);

  static Response html(String body) =>
      Response(200, body: body, headers: {'Content-Type': 'text/html'});
}
