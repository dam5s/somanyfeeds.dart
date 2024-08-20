import 'dart:developer';
import 'dart:io';

import 'package:damo_io_server/app/app_dependencies.dart';
import 'package:damo_io_server/app/app_server.dart';
import 'package:logging/logging.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

Future<HttpServer> _startServer(AppDependencies dependencies) async {
  final server = await buildAppServer(dependencies);

  print('Serving at http://${server.address.host}:${server.port}');

  return server;
}

Future<void> main() async {
  Logger.root.level = Platform.environment['DEBUG_LOG'] == 'true' ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });

  final dependencies = AppDependencies.shared;
  final runner = dependencies.periodicRunner;
  final processor = dependencies.processor;

  runner.runPeriodically(
    callback: processor.process,
    every: const Duration(minutes: 5),
  );

  final useHotreload = Platform.environment['USE_HOTRELOAD'] == 'true';

  if (useHotreload) {
    withHotreload(() => _startServer(dependencies));
  } else {
    await _startServer(dependencies);
  }
}
