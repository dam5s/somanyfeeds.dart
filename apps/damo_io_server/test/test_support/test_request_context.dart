import 'package:damo_io_server/app_dependencies.dart';
import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';

final class _MockRequestContext extends Mock implements RequestContext {}

extension TestRequestContext on AppDependencies {
  RequestContext createTestRequestContext() {
    final context = _MockRequestContext();
    final listArticles = ListArticles(articlesRepo: articles);

    when(() => context.read<ListArticles>()).thenReturn(listArticles);

    return context;
  }
}
