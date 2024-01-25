import 'dart:io';

import 'package:damo_io_server/app_dependencies.dart';
import 'package:test/test.dart';

import '../../routes/[sources].dart' as route;
import '../articles/builders.dart';
import '../test_support/test_request_context.dart';

void main() {
  test('GET /about,social,blog', () async {
    final dependencies = AppDependencies.defaults();
    final context = dependencies.createTestRequestContext();
    final article = buildArticleRecord(
      url: 'https://blog.damo.io/articles/1',
      feedUrl: 'https://blog.damo.io/rss.xml',
      title: 'This is an article',
    );

    dependencies.articles.upsert(article);

    final response = await route.onRequest(context, 'about,social,blog');

    expect(response.statusCode, equals(HttpStatus.ok));

    final body = await response.body();
    expect(body, contains('<main class="articles">'));
    expect(
      body,
      contains('<h1><a href="https://blog.damo.io/articles/1">This is an article</a></h1>'),
    );
  });
}
