import 'package:networking_support/networking_support.dart';

import 'article.dart';

Article _articleFromJson(JsonDecoder json) => Article(
      title: json.field('title'),
      content: json.field('content'),
    );

HttpFuture<Iterable<Article>> fetchArticles(
  HttpClientProvider httpClientProvider,
  AsyncCompute asyncCompute,
  String articlesUrl,
) async {
  return httpClientProvider.withHttpClient((client) async {
    final requestUrl = Uri.parse(articlesUrl);
    final result = await client.sendRequest(HttpMethod.get, requestUrl);

    return result.expectStatusCode(200).tryParseJson(
          (json) => json.objectArray('articles', _articleFromJson),
          async: asyncCompute,
        );
  });
}
