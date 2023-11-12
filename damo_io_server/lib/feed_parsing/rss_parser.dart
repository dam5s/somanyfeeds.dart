import 'package:damo_io_server/prelude/result.dart';

import 'feed_parser.dart';

final class RssParser extends FeedParser {
  FeedParsingResult parse(RawFeed feed) {
    return Err(FeedParsingError.of(message: "not implemented"));
  }
}
