import 'package:html_support/html_builder.dart';
import 'package:test/test.dart';

void main() {

  test('building html', () {
    final rendered = section(attrs: {'id': 'main-section', 'class': 'wide'}, children: [
      h1(text: 'Hello'),
      p(text: 'World'),
    ]);

    final expected = '<section id="main-section" class="wide">'
        '<h1>Hello</h1>'
        '<p>World</p>'
        '</section>';

    expect(rendered, equals(expected));
  });
}
