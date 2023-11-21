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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleRecord &&
          runtimeType == other.runtimeType &&
          feedUrl == other.feedUrl &&
          url == other.url &&
          title == other.title &&
          content == other.content &&
          publishedAt == other.publishedAt;

  @override
  int get hashCode =>
      feedUrl.hashCode ^ url.hashCode ^ title.hashCode ^ content.hashCode ^ publishedAt.hashCode;
}
