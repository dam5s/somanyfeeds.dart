import 'html_presenter.dart';

typedef _TagHtmlPresenterBuilder = HtmlPresenter Function({
  Map<String, String>? attrs,
  Iterable<HtmlPresenter>? children,
  HtmlPresenter? child,
  String? text,
});

_TagHtmlPresenterBuilder _builder(String tag) {
  return ({
    Map<String, String>? attrs,
    Iterable<HtmlPresenter>? children,
    HtmlPresenter? child,
    String? text,
  }) {
    HtmlPresenter? inferredChild;

    if (text != null) {
      inferredChild = TextPresenter(value: text);
    }
    if (child != null) {
      inferredChild = child;
    }
    if (children != null) {
      inferredChild = IterableHtmlPresenter(elements: children);
    }

    return TagHtmlPresenter(
      tag: tag,
      attrs: attrs ?? {},
      child: inferredChild,
    );
  };
}

HtmlPresenter tag({
  required String name,
  Map<String, String>? attrs,
  Iterable<HtmlPresenter>? children,
  HtmlPresenter? child,
  String? text,
}) =>
    _builder(name)(
      attrs: attrs,
      children: children,
      child: child,
      text: text,
    );

HtmlPresenter text(String value) => TextPresenter(value: value);

final section = _builder('section');
final article = _builder('article');
final header = _builder('header');
final aside = _builder('aside');
final div = _builder('div');

final h1 = _builder('h1');
final h2 = _builder('h2');
final h3 = _builder('h3');
final h4 = _builder('h4');
final h5 = _builder('h5');
final h6 = _builder('h6');

final p = _builder('p');
final a = _builder('a');
final ul = _builder('ul');
final li = _builder('li');

final input = _builder('input');
