import 'dart:io';

import 'package:damo_io_server/app_dependencies.dart';
import 'package:test/test.dart';

import '../../routes/articles.dart' as route;
import '../articles/builders.dart';
import '../test_support/test_request_context.dart';


void main() {
  test('GET /articles', () async {
    final dependencies = AppDependencies.defaults();
    final context = dependencies.createTestRequestContext();
    final article = buildArticleRecord(title: 'This is an article');

    dependencies.articles.upsert(article);

    final response = route.onRequest(context);

    expect(response.statusCode, equals(HttpStatus.ok));

    final body = await response.body();
    expect(body, contains('{"articles":['));
    expect(body, contains('"title":"This is an article"'));
  });
}
