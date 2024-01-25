import 'package:damo_io_server/app_dependencies.dart';
import 'package:damo_io_server/source_articles/list_articles_by_sources.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';
import 'package:mocktail/mocktail.dart';

final class _MockRequestContext extends Mock implements RequestContext {}

extension TestRequestContext on AppDependencies {
  RequestContext createTestRequestContext() {
    final context = _MockRequestContext();
    final listArticlesBySources = ListArticlesBySources(feedsRepo: feeds, articlesRepo: articles);
    final layouts = LayoutLoader();

    when(() => context.read<ListArticlesBySources>()).thenReturn(listArticlesBySources);
    when(() => context.read<Future<Layout>>())
        .thenAnswer((_) => layouts.get('resources/layout.html'));

    return context;
  }
}
