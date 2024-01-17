import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:html_support/html_support.dart';
import 'package:logger/logger.dart';

import 'article_presenter.dart';

class ListArticlesPresenter {
  final Iterable<ArticlePresenter> articles;

  ListArticlesPresenter(this.articles);

  Map<String, dynamic> toJson() => {
        'articles': articles.map((it) => it.toJson()).toList(),
      };

  String toHtml() => tag('main',
        attrs: {'class': 'articles'},
        children: articles.map((it) => it.toHtml()),
      );
}

class ListArticles {
  final ArticlesRepository repo;
  final _logger = Logger();

  ListArticles({required this.repo});

  ListArticlesPresenter execute() {
    final records = repo.findAll();
    final articles = records.map(ArticlePresenter.fromRecord).toList();

    _logger.i('Found ${records.length} articles');

    return ListArticlesPresenter(articles);
  }
}
