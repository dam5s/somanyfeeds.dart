import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/feed_parsing/parsed_feed.dart';
import 'package:rss_dart/dart_rss.dart';

import 'date_parsing.dart';

final class AtomParser extends FeedParser {
  @override
  ParsedFeed parse(RawFeed feed) {
    final atom = AtomFeed.parse(feed.content);
    final parsedArticles = atom.items.map(_buildArticle);
    return ParsedFeed(url: feed.url, articles: parsedArticles);
  }

  ParsedArticle _buildArticle(AtomItem item) => ParsedArticle(
        url: item.links.firstOrNull?.href ?? '',
        title: item.title ?? '',
        content: item.content ?? '',
        publishedAt: tryParseDate(item.published ?? '') ?? DateTime.now(),
      );
}
