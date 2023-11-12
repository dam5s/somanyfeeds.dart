import 'package:damo_io_server/feed_parsing/feed_parser.dart';
import 'package:damo_io_server/networking/http.dart';
import 'package:damo_io_server/prelude/result.dart';
import 'package:http/http.dart';

final class DownloadedFeed extends RawFeed {
  final String _content;

  DownloadedFeed(String content) : _content = content;

  @override
  String content() => _content;
}

extension FeedDownloader on Client {

  HttpFuture<DownloadedFeed> download(String url) async {
    final httpRes = await sendRequest(HttpMethod.get, Uri.parse(url));

    return httpRes.mapOk((response) => DownloadedFeed(response.body));
  }
}
