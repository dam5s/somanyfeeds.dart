import 'package:damo_io_server/sources/source.dart';
import 'package:prelude/prelude.dart';

import 'environment_feeds.dart';
import 'feed_record.dart';

final class FeedsRepository {
  Iterable<FeedRecord> findAll() => environmentFeeds.unmodifiable();

  Iterable<FeedRecord> findBySources(Set<Source> sources) =>
      environmentFeeds.where((feed) => sources.contains(feed.source)).unmodifiable();
}
