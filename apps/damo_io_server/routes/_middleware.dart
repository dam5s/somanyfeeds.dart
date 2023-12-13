import 'dart:io';

import 'package:damo_io_server/app_dependencies.dart';
import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

Handler middleware(Handler handler) {
  final appDependencies = AppDependencies.shared;
  final listArticles = ListArticles(articlesRepo: appDependencies.articles);

  return handler.configureCors().use(provider<ListArticles>((_) => listArticles));
}

extension Cors on Handler {
  Handler configureCors() {
    final accessControlAllowOrigin = Platform.environment['ACCESS_CONTROL_ALLOW_ORIGIN'];

    if (accessControlAllowOrigin != null) {
      return use(
        fromShelfMiddleware(
          shelf.corsHeaders(headers: {shelf.ACCESS_CONTROL_ALLOW_ORIGIN: '*'}),
        ),
      );
    }

    return this;
  }
}
