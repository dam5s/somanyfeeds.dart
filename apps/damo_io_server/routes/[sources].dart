import 'package:damo_io_server/dart_frog_support/responses.dart';
import 'package:damo_io_server/source_articles/list_articles_by_sources.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';

Future<Response> onRequest(RequestContext context, String sources) async {
  if (sources == '') {
    return Responses.redirect(SourceLinkPresenter.defaultPath);
  }

  final selectedSources = SourceLinkPresenter.tryParsePath(sources);
  if (selectedSources == null) {
    return Responses.badRequest();
  }

  final listArticles = context.read<ListArticlesBySources>();
  final articles = listArticles.execute(selectedSources);
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

  return Responses.html(
    layout.render({'menu': menu, 'main': articles}),
  );
}
