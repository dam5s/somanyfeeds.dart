import 'package:html_support/src/html_builder.dart';
import 'package:test/test.dart';

void main() {
  test('building html', () {
    final rendered = section(
      attrs: {'id': 'main-section', 'class': 'wide'},
      children: [
        h1(text: 'Hello'),
        p(text: 'World'),
        input(attrs: {'type': 'date'}),
      ],
    ).toHtml();

    final expected = '<section id="main-section" class="wide">'
        '<h1>Hello</h1>'
        '<p>World</p>'
        '<input type="date" />'
        '</section>';

    expect(rendered, equals(expected));
  });
}
