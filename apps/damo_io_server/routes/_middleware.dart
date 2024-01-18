import 'dart:io';

import 'package:damo_io_server/app_dependencies.dart';
import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart' as shelf;

Handler middleware(Handler handler) {
  final appDependencies = AppDependencies.shared;
  final layouts = appDependencies.layouts;
  final layoutPath = 'resources/layout.html';

  return handler
      .configureCors()
      .use(provider<Future<Layout>>((_) => layouts.get(layoutPath)))
      .use(provider<ListArticles>((_) => ListArticles(repo: appDependencies.articles)));
}

extension Cors on Handler {
  Handler configureCors() {
    final accessControlAllowOrigin = Platform.environment['ACCESS_CONTROL_ALLOW_ORIGIN'];

    if (accessControlAllowOrigin != null) {
      return use(
        fromShelfMiddleware(
          shelf.corsHeaders(headers: {shelf.ACCESS_CONTROL_ALLOW_ORIGIN: accessControlAllowOrigin}),
        ),
      );
    }

    return this;
  }
}
