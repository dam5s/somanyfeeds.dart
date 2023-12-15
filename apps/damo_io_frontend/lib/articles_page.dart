import 'package:damo_io_frontend/app_dependencies.dart';
import 'package:damo_io_frontend/articles_api.dart';
import 'package:flutter/material.dart';
import 'package:networking_support/networking_support.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'article.dart';
import 'http_future_builder.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencies = context.appDependencies();
    final articles = fetchArticles(
      dependencies.httpClientProvider,
      dependencies.asyncCompute,
      dependencies.articlesUrl,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('damo.io'),
          ),
          _ArticlesList(articles: articles),
        ],
      ),
    );
  }
}

class _ArticlesList extends StatelessWidget {
  final HttpFuture<Iterable<Article>> articles;

  const _ArticlesList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return HttpFutureBuilder(
      future: articles,
      builder: (context, articleList) =>
          _LoadedArticlesList(articles: articleList),
      useSlivers: true,
    );
  }
}

class _LoadedArticlesList extends StatelessWidget {
  final Iterable<Article> articles;

  const _LoadedArticlesList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
        children: articles.map((a) => _ArticleView(article: a)).toList());
  }
}

class _ArticleView extends StatelessWidget {
  final Article article;

  const _ArticleView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SelectionArea(
        child: Column(
          children: [
            Text(article.title),
            HtmlWidget(article.content),
          ],
        ),
      ),
    );
  }
}
