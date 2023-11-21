import 'package:damo_io_server/articles/articles_repository.dart';
import 'package:test/test.dart';

import 'builders.dart';

void main() {
  test('upsert, with new article', () async {
    final repo = ArticlesRepository();

    final article = buildArticleRecord();
    repo.upsert(article);

    final storedArticles = repo.findAll();
    expect(storedArticles, equals([article]));
  });

  test('upsert, with existing article', () async {
    final repo = ArticlesRepository();

    final originalArticle = buildArticleRecord();
    repo.upsert(originalArticle);

    final updatedArticle = buildArticleRecord(
      title: 'Updated title',
      content: 'Updated content',
      publishedAt: DateTime.now(),
    );
    repo.upsert(updatedArticle);

    final storedArticles = repo.findAll();
    expect(storedArticles, equals([updatedArticle]));
  });
}
