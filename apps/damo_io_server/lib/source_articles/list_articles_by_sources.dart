import 'package:damo_io_server/articles/article_presenter.dart';
import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:html_support/html_support.dart';
import 'package:logging/logging.dart';

class ListArticlesBySourcesPresenter extends HtmlPresenter {
  final Iterable<ArticlePresenter> articles;

  ListArticlesBySourcesPresenter(this.articles);

  @override
  String toHtml() => tag(
        name: 'main',
        attrs: {'class': 'articles'},
        children: articles,
      ).toHtml();
}

class ListArticlesBySources {
  final FeedsRepository feedsRepo;
  final ArticlesRepository articlesRepo;
  final _logger = Logger('ListArticlesBySources');

  ListArticlesBySources({required this.feedsRepo, required this.articlesRepo});

  ListArticlesBySourcesPresenter execute(Set<Source> sources) {
    final feeds = feedsRepo.findBySources(sources);
    final feedUrls = feeds.map((f) => f.url).toSet();
    final articles = articlesRepo.findAllByFeedUrls(feedUrls);

    _logger.info('Found ${articles.length} articles');

    return ListArticlesBySourcesPresenter(
      articles.map(ArticlePresenter.fromRecord).toList(),
    );
  }
}
