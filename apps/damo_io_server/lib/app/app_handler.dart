import 'package:damo_io_server/app/app_dependencies.dart';
import 'package:damo_io_server/app/layout_component.dart';
import 'package:damo_io_server/shelf_support/responses.dart';
import 'package:damo_io_server/source_articles/articles_component.dart';
import 'package:damo_io_server/source_articles/list_articles_by_sources.dart';
import 'package:damo_io_server/sources/source.dart';
import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:jaspr/server.dart';

Future<Handler> buildAppHandler(AppDependencies dependencies) async {
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

    final menuItems =
        Source.values.map((it) => SourceLinkPresenter(source: it, selected: selectedSources));

    final isHtmxRequest = request.headers.containsKey('HX-Request');

    return isHtmxRequest
        ? Responses.partialHtml(ArticlesComponent(menuItems, articles))
        : Responses.htmlDocument(LayoutComponent([ArticlesComponent(menuItems, articles)]));
  };
}
