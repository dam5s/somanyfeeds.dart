import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:async_support/async_support.dart';
import 'package:damo_io_server/feed_processing/feeds_processor.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:html_support/html_support.dart';

class AppDependencies {
  final ArticlesRepository articles;
  final FeedsRepository feeds;
  final PeriodicRunner periodicRunner;
  final FeedsProcessor processor;
  final LayoutLoader layouts;

  AppDependencies({
    required this.articles,
    required this.feeds,
    required this.periodicRunner,
    required this.processor,
    required this.layouts,
  });

  static final shared = AppDependencies.defaults();

  factory AppDependencies.defaults() {
    final articles = ArticlesRepository();
    final feeds = FeedsRepository();
    final periodicRunner = PeriodicRunner();
    final processor = FeedsProcessor(feeds: feeds, articles: articles);
    final layouts = LayoutLoader();

    return AppDependencies(
      articles: articles,
      feeds: feeds,
      periodicRunner: periodicRunner,
      processor: processor,
      layouts: layouts,
    );
  }
}
