import 'dart:io';

import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async => Response(
      statusCode: HttpStatus.found,
      headers: {'location': SourceLinkPresenter.defaultPath},
    );
