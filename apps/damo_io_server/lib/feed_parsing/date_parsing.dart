import 'package:intl/intl.dart';

final _mastodonFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss");

DateTime? tryParseDate(String date) => _mastodonFormat.tryParseUtc(date) ?? DateTime.tryParse(date);

extension TryParse on DateFormat {
  DateTime? tryParseUtc(String date) {
    try {
      return parseUtc(date);
    } on FormatException {
      return null;
    }
  }
}
