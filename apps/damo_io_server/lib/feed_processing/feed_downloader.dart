import 'dart:convert';

import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:networking_support/networking_support.dart';
import 'package:prelude/prelude.dart';
import 'package:http/http.dart';

extension FeedDownloader on Client {
  HttpFuture<RawFeed> download(String url) async {
    final httpRes = await sendRequest(HttpMethod.get, Uri.parse(url));

    return httpRes.mapOk((response) {
      final byteContent = response.bodyBytes;
      final stringContent = utf8.decode(byteContent);
      return RawFeed(url: url, content: stringContent);
    });
  }
}
