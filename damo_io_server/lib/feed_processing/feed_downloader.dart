import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/networking/http.dart';
import 'package:damo_io_server/prelude/result.dart';
import 'package:http/http.dart';

extension FeedDownloader on Client {
  HttpFuture<RawFeed> download(String url) async {
    final httpRes = await sendRequest(HttpMethod.get, Uri.parse(url));

    return httpRes.mapOk((response) => RawFeed(url: url, content: response.body));
  }
}
