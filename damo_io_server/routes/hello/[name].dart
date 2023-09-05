import 'package:damo_io_server/hello.dart';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(
  RequestContext context,
  String name,
) {
  final hello = Hello();
  return Response(body: hello.sayHello(name));
}
