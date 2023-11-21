import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:logger/logger.dart';

import 'article_presenter.dart';

class ListArticlesPresenter {
  final Iterable<ArticlePresenter> articles;

  ListArticlesPresenter(this.articles);

  Map<String, dynamic> toJson() => {
        'articles': articles.map((it) => it.toJson()).toList(),
      };
}

class ListArticles {
  final ArticlesRepository articlesRepo;
  final _logger = Logger();

  ListArticles({required this.articlesRepo});

  ListArticlesPresenter execute() {
    final records = articlesRepo.findAll();
    final articles = records.map(ArticlePresenter.fromRecord).toList();

    _logger.i('Found ${records.length} articles');

    return ListArticlesPresenter(articles);
  }
}
