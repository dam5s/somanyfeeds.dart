import 'package:damo_io_frontend/app_dependencies.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:networking_support/networking_support.dart';
import 'package:provider/provider.dart';

import 'test_http_client_provider.dart';

class TestDependencies {
  final TestHttpClientProvider http = TestHttpClientProvider();

  AppDependencies _buildAppDependencies() => AppDependencies(
        httpClientProvider: http,
        asyncCompute: InlineAsyncCompute(),
        articlesUrl: 'http://localhost:8080/articles',
      );
}

extension WidgetTesterWithTestDependencies on WidgetTester {
  Future<TestDependencies> pumpWithTestDependencies(
    Widget widget, {
    TestDependencies? dependencies,
  }) async {
    final testDeps = dependencies ?? TestDependencies();
    final appDeps = testDeps._buildAppDependencies();

    await pumpWidget(Provider(create: (_) => appDeps, child: widget));

    return testDeps;
  }
}
