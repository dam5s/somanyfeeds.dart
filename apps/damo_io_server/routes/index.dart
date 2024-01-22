import 'dart:io';

import 'package:damo_io_server/sources/source.dart';
import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:dart_frog/dart_frog.dart';

final defaultSources = [Source.about, Source.social, Source.blog];
final defaultLocation = SourceLinkPresenter.path(defaultSources);

Future<Response> onRequest(RequestContext context) async =>
    Response(statusCode: HttpStatus.found, headers: {'location': defaultLocation});
