import 'package:damo_io_server/feed_parsing/parsed_feed.dart';
import 'package:prelude/prelude.dart';
import 'package:intl/intl.dart';
import 'package:rss_dart/dart_rss.dart';

import 'feed_parser.dart';

final class RssParser extends FeedParser {
  @override
  FeedParsingResult parse(RawFeed feed) {
    final rss = RssFeed.parse(feed.content);
    final parsedArticles = rss.items.map(_buildArticle);
    final parsedFeed = ParsedFeed(url: feed.url, articles: parsedArticles);

    return Ok(parsedFeed);
  }

  ParsedArticle _buildArticle(RssItem item) => ParsedArticle(
        url: item.link ?? '',
        title: item.title ?? '',
        content: item.description ?? '',
        publishedAt: _tryParseDate(item.pubDate ?? '') ?? DateTime.now(),
      );

  static final mastodonFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss");

  DateTime? _tryParseDate(String date) =>
      mastodonFormat.tryParseUtc(date) ?? DateTime.tryParse(date);
}

extension TryParse on DateFormat {
  DateTime? tryParseUtc(String date) {
    try {
      return parseUtc(date);
    } on FormatException {
      return null;
    }
  }
}
