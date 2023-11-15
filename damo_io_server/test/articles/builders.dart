import 'package:damo_io_server/articles/article_record.dart';

ArticleRecord buildArticleRecord({
  String? feedUrl,
  String? url,
  String? title,
  String? content,
  DateTime? publishedAt,
}) => ArticleRecord(
  feedUrl: feedUrl ?? 'https://blog.damo.io',
  url: url ?? 'https://blog.damo.io/articles/1',
  title: title ?? 'My Article',
  content: content ?? 'This is the content of My Article',
  publishedAt: publishedAt ?? DateTime(2020, 1, 2, 11, 30, 59),
);
