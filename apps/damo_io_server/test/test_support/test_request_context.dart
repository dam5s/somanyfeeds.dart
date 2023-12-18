import 'package:damo_io_server/app_dependencies.dart';
import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';
import 'package:mocktail/mocktail.dart';

final class _MockRequestContext extends Mock implements RequestContext {}

extension TestRequestContext on AppDependencies {
  RequestContext createTestRequestContext() {
    final context = _MockRequestContext();
    final listArticles = ListArticles(repo: articles);
    final layouts = LayoutLoader();

    when(() => context.read<ListArticles>()).thenReturn(listArticles);
    when(() => context.read<Future<Layout>>())
        .thenAnswer((_) => layouts.get('resources/layout.html'));

    return context;
  }
}
