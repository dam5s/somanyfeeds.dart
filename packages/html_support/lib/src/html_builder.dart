typedef TagBuilder = String Function({
  Map<String, String>? attrs,
  List<String>? children,
  String? text,
});

TagBuilder tag(String name) {
  return ({
    Map<String, String>? attrs,
    List<String>? children,
    String? text,
  }) {
    attrs ??= {};
    children ??= text == null ? [] : [text];

    final renderedChildren = children.join();
    final renderedAttrs =
        attrs.entries.map((e) => ' ${e.key}="${e.value}"').join();

    return "<$name$renderedAttrs>$renderedChildren</$name>";
  };
}

final section = tag('section');
final article = tag('article');
final div = tag('div');

final h1 = tag('h1');
final h2 = tag('h2');
final h3 = tag('h3');
final h4 = tag('h4');
final h5 = tag('h5');
final h6 = tag('h6');

final p = tag('p');
