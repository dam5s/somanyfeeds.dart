import 'package:damo_io_server/articles/article_presenter.dart';
import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:logging/logging.dart';

class ListArticlesBySourcesPresenter {
  final Iterable<ArticlePresenter> articles;

  ListArticlesBySourcesPresenter(this.articles);
}

class ListArticlesBySources {
  final FeedsRepository feedsRepo;
  final ArticlesRepository articlesRepo;
  final _logger = Logger('ListArticlesBySources');

  ListArticlesBySources({required this.feedsRepo, required this.articlesRepo});

  Iterable<ArticlePresenter> execute(Set<Source> sources) {
    final feeds = feedsRepo.findBySources(sources);
    final feedUrls = feeds.map((f) => f.url).toSet();
    final articles = articlesRepo.findAllByFeedUrls(feedUrls);

    _logger.info('Found ${articles.length} articles');

    return articles.map(ArticlePresenter.fromRecord);
  }
}
