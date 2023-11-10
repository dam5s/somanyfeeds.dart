import 'dart:io';

import 'package:damo_io_server/async_support/background_runner.dart';
import 'package:damo_io_server/feeds_processing/feeds_processor.dart';
import 'package:dart_frog/dart_frog.dart';

final _backgroundRunner = BackgroundRunner();
final _processor = FeedsProcessor();

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  _backgroundRunner.runPeriodically(
    callback: _processor.process,
    every: const Duration(minutes: 5),
  );
  return serve(handler, ip, port);
}
