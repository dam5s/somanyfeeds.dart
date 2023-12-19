import 'package:html_support/html_support.dart';
import 'package:test/test.dart';

void main() {
  test('layout builder', () async {
    final layout = await LayoutLoader().get('test/layout.html');

    final rendered = layout.render({
      'title': 'Page Title',
      'main': h1(content: 'Main content'),
    });

    final renderedWithoutNewLines = rendered.replaceAll('\r', '').replaceAll('\n', '');

    final expected = '<html>'
        '<head>'
        '    <title>Page Title</title>'
        '</head>'
        '<body>'
        '    <h1>Main content</h1>'
        '</body>'
        '</html>';

    expect(renderedWithoutNewLines, equals(expected));
  });
}
