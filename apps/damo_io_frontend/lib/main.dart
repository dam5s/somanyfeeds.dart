import 'package:flutter/material.dart';
import 'package:networking_support/networking_support.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app_dependencies.dart';
import 'foundation_async_compute.dart';

void main() {
  runApp(
    Provider(
      create: (_) => AppDependencies(
        httpClientProvider: ConcreteHttpClientProvider(),
        asyncCompute: FoundationAsyncCompute(),
        articlesUrl: 'http://localhost:8080/articles',
      ),
      child: const App(),
    ),
  );
}
