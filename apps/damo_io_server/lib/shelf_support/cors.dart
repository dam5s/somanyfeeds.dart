import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

extension Cors on Pipeline {
  Pipeline configureCors() {
    final accessControlAllowOrigin = Platform.environment['ACCESS_CONTROL_ALLOW_ORIGIN'];

    if (accessControlAllowOrigin != null) {
      return addMiddleware(
        corsHeaders(headers: {ACCESS_CONTROL_ALLOW_ORIGIN: accessControlAllowOrigin}),
      );
    }

    return this;
  }
}
