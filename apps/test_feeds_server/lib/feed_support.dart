import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> buildRssResponse(String fileName) async {
  final body = await File('resources/$fileName').readAsString();

  return Response(
    body: body,
    headers: {'Content-Type': 'application/rss+xml'},
  );
}
