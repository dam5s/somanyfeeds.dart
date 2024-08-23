import 'package:damo_io_server/articles/article_presenter.dart';
import 'package:jaspr/jaspr.dart';

class ArticlesComponent extends StatelessComponent {
  final Iterable<ArticlePresenter> _articles;

  ArticlesComponent(Iterable<ArticlePresenter> articles, {super.key}) : _articles = articles;

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield main_(
      classes: 'articles',
      _articles.map((it) => _ArticleComponent(it)).toList(),
    );
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
          a(href: _article.url, [text(_article.title)]),
        ])
      ]),
      section([
        raw(_article.content),
      ])
    ]);
  }
}
