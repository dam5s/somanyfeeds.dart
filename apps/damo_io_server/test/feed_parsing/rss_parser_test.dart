import 'dart:io';

import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/feed_parsing/rss_parser.dart';
import 'package:prelude/prelude.dart';
import 'package:test/test.dart';

void main() {
  Future<FeedParsingResult> parseFile(String path) async {
    final url = 'file://$path';
    final fileContent = await File(path).readAsString();
    final rawFeed = RawFeed(url: url, content: fileContent);
    return RssParser().tryParse(rawFeed);
  }

  test('parsing mastodon rss', () async {
    final result = await parseFile('test/resources/mastodon.rss');

    expect(result.isOk(), equals(true));

    final maybeFeed = result.orNull();
    final url = maybeFeed?.url ?? '';
    final articles = maybeFeed?.articles ?? [];

    expect(url, equals('file://test/resources/mastodon.rss'));
    expect(articles.length, equals(20));

    final article = articles.first;
    expect(article.url, equals('https://mastodon.kleph.eu/@dam5s/111354148842060596'));
    expect(article.title, equals(''));
    expect(
        article.content,
        equals(
            '<p>Learning Godot.</p><p>So far it&#39;s pretty good. I really appreciated to see that the UI can be scaled to support high DPI displays.</p><p>It seems rare these days to find cross-platform applications with this built-in.</p>'));
    expect(article.publishedAt, equals(DateTime.utc(2023, 11, 4, 20, 24, 33)));
  });

  test('parsing blog rss', () async {
    final result = await parseFile('test/resources/blog.xml');

    expect(result.isOk(), equals(true));

    final maybeFeed = result.orNull();
    final articles = maybeFeed?.articles ?? [];
    final article = articles.first;

    expect(articles.length, equals(5));
    expect(article.publishedAt, equals(DateTime.utc(2021, 11, 21, 19, 12, 00)));

    final errorHandlingArticleTitle = 'Error handling in Kotlin and any modern static type system';
    final errorHandlingArticle = articles.firstWhere((it) => it.title == errorHandlingArticleTitle);
    expect(errorHandlingArticle.content, contains('Enter Kotlin’s sealed classes'));
  });
}
