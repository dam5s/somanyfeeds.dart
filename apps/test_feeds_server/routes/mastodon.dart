import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final body = await File('resources/mastodon.rss').readAsString();

  return Response(
    body: body,
    headers: {'Content-Type': 'application/rss+xml'},
  );
}
