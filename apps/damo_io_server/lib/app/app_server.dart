import 'dart:io';

import 'package:damo_io_server/app/app_dependencies.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

import 'app_handler.dart';

Future<HttpServer> buildAppServer(AppDependencies dependencies, {int? port}) async {
  port ??= int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;

  final pipeline = Pipeline() //
      .addMiddleware(logRequests())
      .addHandler(
        Cascade() //
            .add(createStaticHandler('public'))
            .add(await buildAppHandler(dependencies))
            .handler,
      );

  final server = await serve(pipeline, '0.0.0.0', port);

  server.autoCompress = true;

  return server;
}
