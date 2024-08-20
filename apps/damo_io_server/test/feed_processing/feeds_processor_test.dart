import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:damo_io_server/feed_processing/feeds_processor.dart';
import 'package:damo_io_server/feeds/feeds_repository.dart';
import 'package:test/test.dart';

void main() {
  test('process feeds', () async {
    final feeds = FeedsRepository();
    final articles = ArticlesRepository();
    final processor = FeedsProcessor(feeds: feeds, articles: articles);

    await processor.process();

    expect(articles.findAll().length, greaterThan(0));
  });
}
