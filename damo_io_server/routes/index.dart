import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) =>
    Response(statusCode: HttpStatus.found, headers: {'location': '/articles'});
