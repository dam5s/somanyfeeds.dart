import 'dart:io';

import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/feed_parsing/rss_parser.dart';
import 'package:damo_io_server/prelude/result.dart';
import 'package:test/test.dart';

void main() {

  Future<FeedParsingResult> _parseFile(String path, String url) async {
    final file_content = await File(path).readAsString();
    final raw_feed = RawFeed(url: url, content: file_content);
    return RssParser().parse(raw_feed);
  }

  test('parsing mastodon rss', () async {
    final file_path = 'test/feed_parsing/mastodon.rss';
    final file_url = 'file://$file_path';
    final result = await _parseFile(file_path, file_url);

    expect(result.isOk(), equals(true));

    final maybeFeed = result.orNull();
    final url = maybeFeed?.url ?? '';
    final articles = maybeFeed?.articles ?? [];

    expect(url, equals('file://test/feed_parsing/mastodon.rss'));
    expect(articles.length, equals(20));

    final article = articles.first;
    expect(article.url, equals('https://mastodon.kleph.eu/@dam5s/111354148842060596'));
    expect(article.title, equals(''));
    expect(article.content, equals('<p>Learning Godot.</p><p>So far it&#39;s pretty good. I really appreciated to see that the UI can be scaled to support high DPI displays.</p><p>It seems rare these days to find cross-platform applications with this built-in.</p>'));
    expect(article.publishedAt, equals(DateTime.utc(2023, 11, 4, 20, 24, 33)));
  });

  test('parsing blog rss', () async {
    final file_path = 'test/feed_parsing/blog.xml';
    final file_url = 'file://$file_path';
    final result = await _parseFile(file_path, file_url);

    expect(result.isOk(), equals(true));

    final maybeFeed = result.orNull();
    final articles = maybeFeed?.articles ?? [];
    final article = articles.first;

    expect(articles.length, equals(5));
    expect(article.publishedAt, equals(DateTime.utc(2021, 11, 21, 19, 12, 00)));
  });
}
