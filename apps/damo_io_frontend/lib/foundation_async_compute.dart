import 'dart:async';

import 'package:networking_support/networking_support.dart';
import 'package:flutter/foundation.dart' as foundation;

class FoundationAsyncCompute implements AsyncCompute {
  @override
  Future<R> compute<M, R>(
    FutureOr<R> Function(M) callback,
    M message, {
    String? debugLabel,
  }) {
    return foundation.compute<M, R>(callback, message, debugLabel: debugLabel);
  }
}
