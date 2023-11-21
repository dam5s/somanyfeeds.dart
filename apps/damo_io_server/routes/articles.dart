import 'dart:convert';

import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final listArticles = context.read<ListArticles>();
  final body = listArticles.execute();

  return Response(
    body: jsonEncode(body.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}
