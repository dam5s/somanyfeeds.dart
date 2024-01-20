import 'package:damo_io_server/articles/list_articles.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:html_support/html_support.dart';

Future<Response> onRequest(RequestContext context) async {
  final listArticles = context.read<ListArticles>();
  final articles = listArticles.execute();
  final layout = await context.read<Future<Layout>>();

  final menu = ul(
    attrs: {'class': 'main-menu'},
    children: [
      li(child: a(text: 'About', attrs: {'href': '#'})),
      li(child: a(text: 'Social', attrs: {'href': '#'})),
      li(child: a(text: 'Code', attrs: {'href': '#'})),
      li(child: a(text: 'Blog', attrs: {'href': '#'})),
    ],
  );

  return Response(
    body: layout.render({
      'menu': menu,
      'main': articles,
    }),
    headers: {'Content-Type': 'text/html'},
  );
}
