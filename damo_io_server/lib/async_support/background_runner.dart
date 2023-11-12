import 'dart:async';

import 'async_compute.dart';

final class BackgroundRunner {
  BackgroundRunner({AsyncCompute? asyncCompute})
      : asyncCompute = asyncCompute ?? IsolateAsyncCompute();

  final AsyncCompute asyncCompute;
  Timer? _timer;

  Future runPeriodically({required Future Function() callback, required Duration every}) async {
    await _runInBackground(callback);

    _timer = Timer.periodic(
      every,
      (_) async => await _runInBackground(callback),
    );
  }

  void stop() {
    _timer?.cancel();
  }

  Future _runInBackground(Future Function() callback) async {
    await asyncCompute.compute(
      (_) async => await callback(),
      null,
    );
  }
}
