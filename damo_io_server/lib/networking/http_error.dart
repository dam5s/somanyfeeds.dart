sealed class HttpError {}

final class HttpConnectionError implements HttpError {
  const HttpConnectionError(this.exception);

  final Exception exception;
}

final class HttpUnexpectedStatusCodeError implements HttpError {
  const HttpUnexpectedStatusCodeError(this.expected, this.actual);

  final int expected;
  final int actual;
}

extension HttpErrorMessage on HttpError {
  String message() =>
      switch (this) {
        HttpConnectionError() => 'There was an error connecting',
        HttpUnexpectedStatusCodeError() => 'Unexpected response from api',
      };
}
