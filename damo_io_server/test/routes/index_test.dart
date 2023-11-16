import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/index.dart' as route;

final class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  test('GET /', () {
    final context = _MockRequestContext();
    final response = route.onRequest(context);

    expect(response.statusCode, equals(HttpStatus.found));
    expect(response.headers['location'], equals('/articles'));
  });
}
