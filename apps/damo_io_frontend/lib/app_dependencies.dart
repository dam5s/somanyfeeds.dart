import 'package:flutter/widgets.dart' as widgets;
import 'package:networking_support/networking_support.dart';
import 'package:provider/provider.dart';

final class AppDependencies {
  final HttpClientProvider httpClientProvider;
  final AsyncCompute asyncCompute;
  final String articlesUrl;

  AppDependencies({
    required this.httpClientProvider,
    required this.asyncCompute,
    required this.articlesUrl,
  });
}

extension AppDependenciesGetter on widgets.BuildContext {
  AppDependencies appDependencies() => Provider.of<AppDependencies>(this, listen: false);
}
