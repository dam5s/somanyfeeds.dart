import 'dart:convert';
import 'dart:io';

import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/feed_processing/feeds_processor.dart';
import 'package:damo_io_server/feeds/feed_record.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:test/test.dart';

Future<Response> _rssResponse(String fileName) async {
  final bodyString = await File(fileName).readAsString();
  final bodyBytes = utf8.encode(bodyString);

  return Response(
    200,
    body: bodyBytes,
    encoding: latin1, // use latin1 to ensure we actually decode as utf8
  );
}

Future<Response> serveFeeds(Request request) async => //
    switch (request.url.path) {
      'blog' => await _rssResponse('test/resources/blog.xml'),
      'mastodon' => await _rssResponse('test/resources/mastodon.rss'),
      String() => Response(404),
    };

Future<HttpServer> startServer() => serve(serveFeeds, '0.0.0.0', 0);

void main() {
  late HttpServer server;

  setUp(() async {
    server = await startServer();
  });

  tearDown(() {
    server.close(force: true);
  });

  test('process feeds', () async {
    final testFeeds = [
      FeedRecord(source: Source.blog, url: 'http://localhost:${server.port}/blog'),
      FeedRecord(source: Source.social, url: 'http://localhost:${server.port}/mastodon'),
    ];

    final feeds = FeedsRepository(feeds: testFeeds);
    final articles = ArticlesRepository();
    final processor = FeedsProcessor(feeds: feeds, articles: articles);

    await processor.process();

    expect(articles.findAll().length, equals(25));

    final errorHandlingArticleTitle = 'Error handling in Kotlin and any modern static type system';
    final errorHandlingArticle = articles.findAll().firstWhere(
          (it) => it.title == errorHandlingArticleTitle,
        );
    expect(errorHandlingArticle.content, contains('Enter Kotlin’s sealed classes'));

    var godotPosts = articles.findAll().where((it) => it.content.contains("Learning Godot"));
    expect(godotPosts.length, equals(1));
  });
}
