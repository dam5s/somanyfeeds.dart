import 'package:damo_io_server/feed_parsing/parsed_feed.dart';
import 'package:rss_dart/dart_rss.dart';

import 'date_parsing.dart';
import 'feed_parser.dart';

final class RssParser extends FeedParser {
  @override
  ParsedFeed parse(RawFeed feed) {
    final rss = RssFeed.parse(feed.content);
    final parsedArticles = rss.items.map(_buildArticle);
    return ParsedFeed(url: feed.url, articles: parsedArticles);
  }

  ParsedArticle _buildArticle(RssItem item) => ParsedArticle(
        url: item.link ?? '',
        title: item.title ?? '',
        content: item.description ?? '',
        publishedAt: tryParseDate(item.pubDate ?? '') ?? DateTime.now(),
      );
}
