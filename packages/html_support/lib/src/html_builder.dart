typedef _TagBuilder = String Function({
  Map<String, String>? attrs,
  Iterable<String>? children,
  String? content,
});

_TagBuilder _builder(String name) {
  return ({
    Map<String, String>? attrs,
    Iterable<String>? children,
    String? content,
  }) {
    attrs ??= {};
    content = content ?? children?.join();

    final renderedAttrs = attrs.entries.map((e) => ' ${e.key}="${e.value}"').join();

    return switch (content) {
      null => '<$name$renderedAttrs />',
      _ => '<$name$renderedAttrs>$content</$name>',
    };
  };
}

String tag(
  String name, {
  Map<String, String>? attrs,
  Iterable<String>? children,
  String? content,
}) {
  return _builder(name)(attrs: attrs, children: children, content: content);
}

final section = _builder('section');
final article = _builder('article');
final header = _builder('header');
final div = _builder('div');

final h1 = _builder('h1');
final h2 = _builder('h2');
final h3 = _builder('h3');
final h4 = _builder('h4');
final h5 = _builder('h5');
final h6 = _builder('h6');

final p = _builder('p');
final a = _builder('a');

final input = _builder('input');
