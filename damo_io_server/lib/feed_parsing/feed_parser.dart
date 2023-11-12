import 'package:damo_io_server/prelude/result.dart';

import 'parsed_feed.dart';

typedef FeedParsingResult = Result<ParsedFeed, FeedParsingError>;

final class FeedParsingError {
  final Iterable<String> messages;

  FeedParsingError({required this.messages});

  factory FeedParsingError.of({required String message}) => FeedParsingError(messages: [message]);

  FeedParsingError append(FeedParsingError error) {
    final newMessages = List.of(messages)..addAll(error.messages);
    return FeedParsingError(messages: newMessages);
  }
}

enum FeedType { Rss, Atom }

abstract class RawFeed {
  String content();
}

abstract class FeedParser {
  FeedParsingResult parse(RawFeed feed);
}
