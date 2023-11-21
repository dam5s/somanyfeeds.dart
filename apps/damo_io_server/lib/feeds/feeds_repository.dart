import 'dart:collection';

import 'feed_record.dart';

final class FeedsRepository {
  final Iterable<FeedRecord> _records = [
    FeedRecord(url: 'https://blog.damo.io/rss.xml'),
    FeedRecord(url: 'https://mastodon.kleph.eu/users/dam5s.rss'),
  ];

  Iterable<FeedRecord> findAll() => UnmodifiableListView(_records);
}
