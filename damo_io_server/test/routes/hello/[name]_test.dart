import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../routes/hello/[name].dart' as route;

final class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  test('GET /hello/world', () {
    final context = _MockRequestContext();
    final response = route.onRequest(context, 'world');

    expect(response.statusCode, equals(HttpStatus.ok));
    expect(response.body(), completion(equals('Hello, world')));
  });
}
