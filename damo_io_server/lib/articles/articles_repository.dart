import 'article_record.dart';

final class ArticlesRepository {
  var _articles = List<ArticleRecord>.empty(growable: true);

  Iterable<ArticleRecord> findAll() {
    return _articles;
  }

  void upsert(ArticleRecord article) {
    if (_exists(article)) {
      _update(article);
    } else {
      _create(article);
    }
  }

  void _create(ArticleRecord article) {
    _articles.add(article);
  }

  void _update(ArticleRecord article) {
    _articles = _articles.map((a) {
      if (_areTheSame(a, article)) {
        return article;
      } else {
        return a;
      }
    }).toList();
  }

  bool _exists(ArticleRecord article) => _articles.any((other) => _areTheSame(article, other));

  bool _areTheSame(ArticleRecord articleA, ArticleRecord articleB) =>
      articleA.feedUrl == articleB.feedUrl && articleA.url == articleB.url;
}
