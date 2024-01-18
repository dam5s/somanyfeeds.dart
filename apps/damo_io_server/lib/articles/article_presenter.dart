import 'package:damo_io_server/articles/article_record.dart';
import 'package:html_support/html_support.dart';

class ArticlePresenter extends HtmlPresenter {
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

  @override
  String toHtml() => article(
        children: [
          header(children: [
            h1(child: a(attrs: {'href': url}, text: title)),
          ]),
          section(text: content),
        ],
      ).toHtml();
}
