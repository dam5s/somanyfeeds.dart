import 'dart:io';

import 'package:networking_support/networking_support.dart';
import 'package:test/test.dart';

import 'articles/builders.dart';
import 'test_server.dart';

void main() {
  late TestServer server;

  setUp(() async {
    server = await TestServer.start();
  });

  tearDown(() async {
    await server.close();
  });

  test('GET /', () async {
    final response = await server.request(HttpMethod.get, '/');

    expect(response?.statusCode, equals(HttpStatus.found));
    expect(response?.headers['location'], equals('/about,social,blog'));
  });

  test('GET /about,social,blog', () async {
    final article = buildArticleRecord(
      url: 'https://blog.damo.io/articles/1',
      feedUrl: 'https://blog.damo.io/rss.xml',
      title: 'This is an article',
    );

    server.dependencies.articles.upsert(article);

    final response = await server.request(HttpMethod.get, '/about,social,blog');

    expect(response?.statusCode, equals(HttpStatus.ok));

    final body = response?.body;
    expect(body, contains('<main class="articles">'));
    expect(
      body,
      contains('<h1><a href="https://blog.damo.io/articles/1">This is an article</a></h1>'),
    );
  });
}
