import 'dart:async';
import 'dart:isolate';

abstract class AsyncCompute {
  Future<R> compute<M, R>(FutureOr<R> Function(M param) callback, M message, {String? debugLabel});
}

class IsolateAsyncCompute implements AsyncCompute {
  @override
  Future<R> compute<M, R>(
    FutureOr<R> Function(M param) callback,
    M message, {
    String? debugLabel,
  }) =>
      Isolate.run(() => callback(message), debugName: debugLabel);
}
