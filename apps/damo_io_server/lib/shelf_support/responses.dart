import 'dart:async';
import 'dart:io';

import 'package:jaspr/server.dart';

abstract class Responses {
  static Response redirect(String location) =>
      Response(HttpStatus.found, headers: {'location': location});

  static Response badRequest() => Response(HttpStatus.badRequest);

  static Future<Response> htmlDocument(Component component) async {
    final renderedHtml = await renderComponent(component);

    return Response(200, body: renderedHtml, headers: {'Content-Type': 'text/html'});
  }

  static Future<Response> partialHtml(Component component) async {
    final renderedHtml = await renderComponent(component, standalone: true);

    return Response(200, body: renderedHtml, headers: {'Content-Type': 'text/html'});
  }
}
