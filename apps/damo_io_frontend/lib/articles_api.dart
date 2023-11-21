import 'package:http/http.dart';
import 'package:networking_support/networking_support.dart';
import 'package:prelude/prelude.dart';

import 'article.dart';

extension ArticlesApi on Client {
  HttpFuture<List<Article>> fetchArticles() async {
    return Err(HttpConnectionError(Exception('Not implemented')));
  }
}
