import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';

Future<Response> onRequest(RequestContext context) async {
  final listArticles = context.read<ListArticles>();
  final articles = listArticles.execute();
  final layout = await context.read<Future<Layout>>();

  // TODO respond based on accept header

  return Response(
    body: layout.render({'main': articles.toHtml()}),
    headers: {'Content-Type': 'text/html'},
  );
}
