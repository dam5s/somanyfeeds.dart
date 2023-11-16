import 'package:damo_io_server/app_dependencies.dart';
import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  final appDependencies = AppDependencies.shared;
  final listArticles = ListArticles(articlesRepo: appDependencies.articles);

  return handler.use(provider<ListArticles>((_) => listArticles));
}
