import 'package:damo_io_frontend/app_dependencies.dart';
import 'package:damo_io_frontend/articles_api.dart';
import 'package:flutter/material.dart';
import 'package:networking_support/networking_support.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('damo.io'),
      ),
      body: Center(
        child: _ArticlesList(articles: articles),
      ),
    );
  }
}

class _ArticlesList extends StatelessWidget {
  final HttpFuture<Iterable<Article>> _articles;

  const _ArticlesList({super.key, required HttpFuture<Iterable<Article>> articles})
      : _articles = articles;

  @override
  Widget build(BuildContext context) {
    return HttpFutureBuilder(
      future: _articles,
      builder: (context, articleList) => Text('We got ${articleList.length} articles'),
    );
  }
}
