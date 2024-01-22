import 'package:damo_io_server/articles/list_articles.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';

Future<Response> onRequest(RequestContext context, String sources) async {
  final selectedSources = SourceLinkPresenter.tryParsePath(sources);
  if (selectedSources == null) {
    return Response(statusCode: 400);
  }

  final listArticles = context.read<ListArticles>();
  final articles = listArticles.execute();
  final layout = await context.read<Future<Layout>>();

  final menu = ul(
    attrs: {'class': 'main-menu'},
    children: Source.values
        .map((it) => SourceLinkPresenter(
              source: it,
              selected: selectedSources,
            ))
        .map((link) => li(child: link)),
  );

  return Response(
    body: layout.render({
      'menu': menu,
      'main': articles,
    }),
    headers: {'Content-Type': 'text/html'},
  );
}
