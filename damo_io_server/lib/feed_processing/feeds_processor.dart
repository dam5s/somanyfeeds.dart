import 'dart:async';

import 'package:damo_io_server/articles/article_record.dart';
import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/feed_parsing/parsed_feed.dart';
import 'package:damo_io_server/feed_parsing/rss_parser.dart';
import 'package:damo_io_server/feeds/feed_record.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:damo_io_server/networking/http_client_provider.dart';
import 'package:damo_io_server/prelude/result.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'feed_downloader.dart';

final class FeedsProcessor {
  final FeedsRepository _feeds;
  final ArticlesRepository _articles;
  final HttpClientProvider _clientProvider;
  final Iterable<FeedParser> _parsers;
  final Logger _logger = Logger();

  static final _defaultParsers = [
    RssParser(),
  ];

  FeedsProcessor({
    FeedsRepository? feeds,
    ArticlesRepository? articles,
    HttpClientProvider? httpClientProvider,
    Iterable<FeedParser>? parsers,
  })  : _feeds = feeds ?? FeedsRepository(),
        _articles = articles ?? ArticlesRepository(),
        _clientProvider = httpClientProvider ?? ConcreteHttpClientProvider(),
        _parsers = parsers ?? _defaultParsers;

  Future process() async {
    final allFeeds = _feeds.findAll();

    _clientProvider.withHttpClient((client) async {
      for (final feed in allFeeds) {
        final processingResult = await _processFeed(client, feed);

        switch (processingResult) {
          case Ok(value: final feed):
            await _persistFeedResult(feed);
          case Err(:final error):
            _logger.e('Error processing feed ${feed}', error: error);
        }
      }
    });
  }

  Future<FeedParsingResult> _processFeed(Client client, FeedRecord feed) async {
    final downloadResult = await client.download(feed.url);

    switch (downloadResult) {
      case Ok(value: final download):
        FeedParsingResult? overallResult = null;

        for (final p in _parsers) {
          final processorResult = p.parse(download);

          switch ((processorResult, overallResult)) {
            case (Ok(:final value), _):
              return Ok(value);
            case (Err(error: final err1), (Err(error: final err2))):
              overallResult = Err(err1.append(err2));
            case (Err(:final error), _):
              overallResult = Err(error);
          }
        }

        return overallResult ?? Err(FeedParsingError.of(message: 'No feed processors available'));

      case Err(:final error):
        return Err(FeedParsingError.of(message: 'Failed to download feed: ${error.toString()}'));
    }
  }

  Future _persistFeedResult(ParsedFeed feed) async {
    // if we were to use a database, this would be in a transaction

    for (final article in feed.articles) {
      final record = ArticleRecord(
        feedUrl: feed.url,
        url: article.url,
        title: article.title,
        content: article.content,
        publishedAt: article.publishedAt,
      );

      _articles.upsert(record);
    }

    // TODO cleanup old articles
  }
}
