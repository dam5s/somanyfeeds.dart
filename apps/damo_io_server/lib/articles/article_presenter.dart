import 'package:damo_io_server/articles/article_record.dart';

class ArticlePresenter {
  final String feedUrl;
  final String url;
  final String title;
  final String content;
  final int publishedAt;

  ArticlePresenter({
    required this.feedUrl,
    required this.url,
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  factory ArticlePresenter.fromRecord(ArticleRecord record) => ArticlePresenter(
        feedUrl: record.feedUrl,
        url: record.url,
        title: record.title,
        content: record.content,
        publishedAt: record.publishedAt.millisecondsSinceEpoch,
      );

  Map<String, dynamic> toJson() => {
        'feedUrl': feedUrl,
        'url': url,
        'title': title,
        'content': content,
        'publishedAt': publishedAt,
      };
}
