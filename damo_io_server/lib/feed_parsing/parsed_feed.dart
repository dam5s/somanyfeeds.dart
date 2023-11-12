final class ParsedFeed {
  final String url;
  final Iterable<ParsedArticle> articles;

  ParsedFeed({required this.url, required this.articles});
}

final class ParsedArticle {
  final String url;
  final String title;
  final String content;
  final DateTime publishedAt;


  ParsedArticle({
    required this.url,
    required this.title,
    required this.content,
    required this.publishedAt,
  });
}
