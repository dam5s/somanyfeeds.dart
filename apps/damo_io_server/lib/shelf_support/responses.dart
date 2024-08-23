import 'dart:io';

import 'package:jaspr/server.dart';

abstract class Responses {
  static Response redirect(String location) =>
      Response(HttpStatus.found, headers: {'location': location});

  static Response badRequest() => Response(HttpStatus.badRequest);

  static Future<Response> html(Component component) async {
    final document = Document(base: '/', body: component);
    final renderedHtml = await renderComponent(document);

    return Response(200, body: renderedHtml, headers: {'Content-Type': 'text/html'});
  }
}
