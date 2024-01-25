import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

abstract class Responses {
  static Response redirect(String location) =>
      Response(statusCode: HttpStatus.found, headers: {'location': location});

  static Response badRequest() => Response(statusCode: HttpStatus.badRequest);

  static Response html(String body) => Response(body: body, headers: {'Content-Type': 'text/html'});
}
