import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

Future<Response> _rssResponse(String fileName) async {
  final body = await File('resources/$fileName').readAsString();

  return Response(
    200,
    body: body,
    headers: {'Content-Type': 'application/rss+xml'},
  );
}

Future<void> main() async {
  final server = await serve((request) async {
    switch (request.url.path) {
      case 'blog':
        return _rssResponse('blog.xml');
      case 'mastodon':
        return _rssResponse('mastodon.rss');
      case String():
        return Response(404);
    }
  }, '0.0.0.0', 8181);

  print('Serving at http://${server.address.host}:${server.port}');
}
