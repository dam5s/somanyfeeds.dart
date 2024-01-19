import 'dart:io';

import 'package:damo_io_server/app_dependencies.dart';
import 'package:dart_frog/dart_frog.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  final dependencies = AppDependencies.shared;
  final runner = dependencies.periodicRunner;
  final processor = dependencies.processor;

  runner.runPeriodically(
    callback: processor.process,
    every: const Duration(minutes: 5),
  );

  return serve(handler, ip, port);
}
