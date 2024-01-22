final class ArticleRecord {
  final String feedUrl;
  final String url;
  final String title;
  final String content;
  final DateTime publishedAt;

  ArticleRecord({
    required this.feedUrl,
    required this.url,
    required this.title,
    required this.content,
    required this.publishedAt,
  });
}
