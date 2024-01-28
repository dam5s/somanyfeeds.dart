import 'dart:io';

import 'package:damo_io_server/sources/source.dart';

import 'feed_record.dart';

final Iterable<FeedRecord> environmentFeeds =
    Platform.environment['USE_TEST_FEEDS'] == 'true' ? _testFeeds : _defaultFeeds;

final Iterable<FeedRecord> _defaultFeeds = [
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

final Iterable<FeedRecord> _testFeeds = [
  FeedRecord(
    source: Source.blog,
    url: 'http://localhost:8081/blog',
  ),
  FeedRecord(
    source: Source.social,
    url: 'http://localhost:8081/mastodon',
  ),
];
