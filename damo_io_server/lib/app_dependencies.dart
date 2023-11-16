import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/async_support/periodic_runner.dart';
import 'package:damo_io_server/feed_processing/feeds_processor.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';

class AppDependencies {
  final ArticlesRepository articles;
  final FeedsRepository feeds;
  final PeriodicRunner periodicRunner;
  final FeedsProcessor processor;

  AppDependencies({
    required this.articles,
    required this.feeds,
    required this.periodicRunner,
    required this.processor,
  });

  static final shared = AppDependencies.defaults();

  factory AppDependencies.defaults() {
    final articles = ArticlesRepository();
    final feeds = FeedsRepository();
    final periodicRunner = PeriodicRunner();
    final processor = FeedsProcessor(feeds: feeds, articles: articles);

    return AppDependencies(
      articles: articles,
      feeds: feeds,
      periodicRunner: periodicRunner,
      processor: processor,
    );
  }
}
