import 'dart:collection';

import 'article_record.dart';

final class ArticlesRepository {
  List<ArticleRecord> _articles = [];

  Iterable<ArticleRecord> findAll() =>
      UnmodifiableListView(_articles);

  void upsert(ArticleRecord article) {
    //TODO
  }
}
