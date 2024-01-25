import 'package:prelude/prelude.dart';
import 'package:damo_io_server/sources/source.dart';

import 'feed_record.dart';

final class FeedsRepository {
  final Iterable<FeedRecord> _records = [
    FeedRecord(
      source: Source.blog,
      url: 'https://blog.damo.io/rss.xml',
    ),
    FeedRecord(
      source: Source.social,
      url: 'https://mastodon.kleph.eu/users/dam5s.rss',
    ),
    FeedRecord(
      source: Source.social,
      url: 'https://bsky.app/profile/did:plc:zvnvcicnso363xz3gu6ho3mw/rss',
    ),
    FeedRecord(
      source: Source.code,
      url: 'https://github.com/dam5s.atom',
    ),
  ];

  Iterable<FeedRecord> findAll() => _records.unmodifiable();

  Iterable<FeedRecord> findBySources(Set<Source> sources) =>
      _records.where((feed) => sources.contains(feed.source)).unmodifiable();
}
