import 'package:damo_io_server/sources/source.dart';
import 'package:prelude/prelude.dart';

import 'environment_feeds.dart';
import 'feed_record.dart';

final class FeedsRepository {
  final Iterable<FeedRecord> _feeds;

  FeedsRepository({Iterable<FeedRecord>? feeds}) : _feeds = feeds ?? environmentFeeds;

  Iterable<FeedRecord> findAll() => _feeds.unmodifiable();

  Iterable<FeedRecord> findBySources(Set<Source> sources) =>
      _feeds.where((feed) => sources.contains(feed.source)).unmodifiable();
}
