import 'package:html_support/html_support.dart';
import 'package:test/test.dart';

void main() {
  test('layout builder', () async {
    final layout = await LayoutLoader().get('test/layout.html');

    final rendered = layout.render({
      'title': 'Page Title',
      'main': h1(content: 'Main content'),
    });

    final expected = '<html>\r\n'
        '<head>\r\n'
        '    <title>Page Title</title>\r\n'
        '</head>\r\n'
        '<body>\r\n'
        '    <h1>Main content</h1>\r\n'
        '</body>\r\n'
        '</html>';

    expect(rendered, equals(expected));
  });
}
