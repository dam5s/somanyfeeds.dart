import 'package:dart_frog/dart_frog.dart';
import 'package:test_feeds_server/feed_support.dart';

Future<Response> onRequest(RequestContext context) => buildRssResponse('mastodon.rss');
