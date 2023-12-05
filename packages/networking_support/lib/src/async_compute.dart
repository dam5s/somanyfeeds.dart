import 'dart:async';

abstract class AsyncCompute {
  Future<R> compute<M, R>(
    FutureOr<R> Function(M message) callback,
    M message, {
    String? debugLabel,
  });
}

class InlineAsyncCompute extends AsyncCompute {
  @override
  Future<R> compute<M, R>(
    FutureOr<R> Function(M message) callback,
    M message, {
    String? debugLabel,
  }) async {
    return callback(message);
  }
}
