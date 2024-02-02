import 'package:damo_io_server/app/app_dependencies.dart';
import 'package:damo_io_server/shelf_support/responses.dart';
import 'package:damo_io_server/source_articles/list_articles_by_sources.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:html_support/html_support.dart';
import 'package:shelf/shelf.dart';

Future<Handler> buildAppHandler(AppDependencies dependencies) async {
  final layout = await dependencies.layouts.get('resources/layout.html');
  final action = ListArticlesBySources(
    feedsRepo: dependencies.feeds,
    articlesRepo: dependencies.articles,
  );

  return (Request request) async {
    final path = request.url.path;
    if (path == '') {
      return Responses.redirect(SourceLinkPresenter.defaultPath);
    }

    final selectedSources = SourceLinkPresenter.tryParsePath(path);
    if (selectedSources == null) {
      return Responses.badRequest();
    }

    final articles = action.execute(selectedSources);

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
  };
}
