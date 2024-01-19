import 'dart:async';

import 'package:damo_io_server/articles/article_record.dart';
import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/feed_parsing/parsed_feed.dart';
import 'package:damo_io_server/feed_parsing/rss_parser.dart';
import 'package:damo_io_server/feeds/feed_record.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:networking_support/networking_support.dart';
import 'package:prelude/prelude.dart';
import 'package:logger/logger.dart';

import 'feed_downloader.dart';

final class FeedsProcessor {
  final FeedsRepository _feeds;
  final ArticlesRepository _articles;
  final HttpClientProvider _clientProvider;
  final AsyncCompute _asyncCompute;
  final Iterable<FeedParser> _parsers;
  final Logger _logger = Logger();

  static final _defaultParsers = [
    RssParser(),
  ];

  FeedsProcessor({
    FeedsRepository? feeds,
    ArticlesRepository? articles,
    HttpClientProvider? httpClientProvider,
    AsyncCompute? asyncCompute,
    Iterable<FeedParser>? parsers,
  })  : _feeds = feeds ?? FeedsRepository(),
        _articles = articles ?? ArticlesRepository(),
        _clientProvider = httpClientProvider ?? ConcreteHttpClientProvider(),
        _asyncCompute = asyncCompute ?? IsolateAsyncCompute(),
        _parsers = parsers ?? _defaultParsers;

  Future<void> process() async {
    final allFeeds = _feeds.findAll();

    for (final feed in allFeeds) {
      final processingResult = await _asyncCompute.compute(_processFeed, feed);

      switch (processingResult) {
        case Ok(value: final feed):
          _logger.i('Feed processed ${feed.url} with ${feed.articles.length} articles');
          await _persistFeedResult(feed);
        case Err(:final error):
          _logger.e('Error processing feed $feed', error: error);
      }
    }
  }

  Future<FeedParsingResult> _processFeed(FeedRecord feed) async {
    final downloadResult =
        await _clientProvider.withHttpClient((client) => client.download(feed.url));

    switch (downloadResult) {
      case Ok(value: final download):
        FeedParsingResult? overallResult;

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

  Future<void> _persistFeedResult(ParsedFeed feed) async {
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
