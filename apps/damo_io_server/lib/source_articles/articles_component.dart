import 'package:damo_io_server/articles/article_presenter.dart';
import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:jaspr/jaspr.dart';

class _MenuListItem extends StatelessComponent {
  final SourceLinkPresenter link;

  _MenuListItem(this.link);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final path = link.path();
    final label = link.source.name;
    final classes = link.isSelected ? 'selected' : null;

    final htmxAttributes = {
      'hx-get': path,
      'hx-trigger': 'click',
      'hx-target': '#content',
      'hx-swap': 'outerHTML',
      'hx-push-url': 'true',
    };

    yield li([
      a(href: path, classes: classes, attributes: htmxAttributes, [
        text(label),
      ]),
    ]);
  }
}

class ArticlesComponent extends StatelessComponent {
  final Iterable<SourceLinkPresenter> _menuItems;
  final Iterable<ArticlePresenter> _articles;

  ArticlesComponent(
    Iterable<SourceLinkPresenter> menuItems,
    Iterable<ArticlePresenter> articles, {
    super.key,
  })  : _menuItems = menuItems,
        _articles = articles;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(id: 'content', [
      aside([
        h1([text('damo.io')]),
        ul(
          classes: 'main-menu',
          _menuItems.map((it) => _MenuListItem(it)).toList(),
        ),
      ]),
      main_(
        classes: 'articles',
        _articles.map((it) => _ArticleComponent(it)).toList(),
      ),
    ]);
  }
}

class _ArticleComponent extends StatelessComponent {
  final ArticlePresenter _article;

  _ArticleComponent(this._article);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield article([
      header([
        h1([
          a(href: _article.url, [
            text(_article.title),
          ]),
        ])
      ]),
      section([
        raw(_article.content),
      ])
    ]);
  }
}
