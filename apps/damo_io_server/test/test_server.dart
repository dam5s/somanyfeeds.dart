import 'dart:io';

import 'package:path/path.dart';
import 'package:damo_io_server/app/app_dependencies.dart';
import 'package:damo_io_server/app/app_server.dart';
import 'package:http/http.dart';
import 'package:networking_support/networking_support.dart';
import 'package:prelude/prelude.dart';

class TestServer {
  final AppDependencies dependencies;

  final HttpServer _server;
  final HttpClientProvider _clientProvider = ConcreteHttpClientProvider();

  TestServer._(this._server, this.dependencies);

  static Future<TestServer> start() async {
    final dependencies = AppDependencies.defaults();

    await _setWorkaroundForStaticWebDirResolution();

    final server = await buildAppServer(dependencies);
    return TestServer._(server, dependencies);
  }

  static Future<void> _setWorkaroundForStaticWebDirResolution() async {
    final targetDir = dirname(Platform.script.toFilePath());
    await File(join(targetDir, 'pubspec.yaml')).create();
  }

  Future<Response?> request(HttpMethod method, String path) async =>
      _clientProvider.withHttpClient((client) async {
        final result = await client.sendRequest(
          HttpMethod.get,
          Uri.parse('http://localhost:${_server.port}$path'),
        );

        return result.orNull();
      });

  Future<void> close() {
    return _server.close();
  }
}
