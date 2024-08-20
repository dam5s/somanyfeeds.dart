import 'dart:developer';
import 'dart:io';

import 'package:damo_io_server/app/app_dependencies.dart';
import 'package:damo_io_server/app/app_server.dart';
import 'package:logging/logging.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

void _configureLogging({required bool printDebugLogs}) {
  Logger.root.level = printDebugLogs ? Level.FINE : Level.INFO;

  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });
}

Future<HttpServer> _startServer(AppDependencies dependencies, int port) async {
  final server = await buildAppServer(dependencies, port: port);

  Logger('server').info('Serving at http://${server.address.host}:${server.port}');

  return server;
}

Future<void> main() async {
  final printDebugLogs = Platform.environment['PRINT_DEBUG_LOGS'] == 'true';
  final useHotreload = Platform.environment['USE_HOTRELOAD'] == 'true';
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;

  _configureLogging(printDebugLogs: printDebugLogs);

  final dependencies = AppDependencies.shared;
  final runner = dependencies.periodicRunner;
  final processor = dependencies.processor;

  runner.runPeriodically(
    callback: processor.process,
    every: const Duration(minutes: 5),
  );

  if (useHotreload) {
    withHotreload(() => _startServer(dependencies, port));
  } else {
    await _startServer(dependencies, port);
  }
}
