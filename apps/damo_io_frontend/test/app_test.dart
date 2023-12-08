import 'package:damo_io_frontend/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_dependencies.dart';

void main() {
  testWidgets('App, on success', (final tester) async {
    final testDependencies = TestDependencies();

    testDependencies.http.stub((
      url: 'http://localhost:8080/articles',
      statusCode: 200,
      body: {
        'articles': [
          {
            'feedUrl': 'https://blog.damo.io/rss.xml',
            'url': 'https://blog.damo.io/posts/initial-monitor',
            'title': 'initialMonitor',
            'content': '<p>This blog post',
            'publishedAt': 1637521920000
          },
          {
            'feedUrl': 'https://blog.damo.io/rss.xml',
            'url': 'https://blog.damo.io/posts/kotlin-testing-with-aspen-and-aspen-spring',
            'title': 'Kotlin testing with Aspen and Aspen Spring',
            'content': '<p>TL;DR',
            'publishedAt': 1467774897000
          },
        ]
      },
    ));

    await tester.pumpWithTestDependencies(const App(), dependencies: testDependencies);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('We got 2 articles'), findsOneWidget);
  });

  testWidgets('App, when failing to load articles', (final tester) async {
    final testDependencies = TestDependencies();

    testDependencies.http.stub((
      url: 'http://localhost:8080/articles',
      statusCode: 500,
      body: {'message': 'Oops'},
    ));

    await tester.pumpWithTestDependencies(const App(), dependencies: testDependencies);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Unexpected response from api'), findsOneWidget);
  });
}
