import 'package:damo_io_frontend/app.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_dependencies.dart';

void main() {
  testWidgets('App', (final tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    expect(find.text('No articles loaded yet'), findsOneWidget);
  });
}
