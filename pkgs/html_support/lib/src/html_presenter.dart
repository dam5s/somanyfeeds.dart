abstract class HtmlPresenter {
  String toHtml();
}

class TextPresenter extends HtmlPresenter {
  final String value;

  TextPresenter({required this.value});

  @override
  String toHtml() => value;
}

class IterableHtmlPresenter extends HtmlPresenter {
  final Iterable<HtmlPresenter> elements;

  IterableHtmlPresenter({required this.elements});

  @override
  String toHtml() => elements.map((it) => it.toHtml()).join();
}

class TagHtmlPresenter extends HtmlPresenter {
  final String tag;
  final Map<String, String> attrs;
  final HtmlPresenter? child;

  TagHtmlPresenter({required this.tag, required this.attrs, required this.child});

  @override
  String toHtml() {
    final renderedAttrs = attrs.entries.map((e) => ' ${e.key}="${e.value}"').join();

    return switch (child) {
      null => '<$tag$renderedAttrs />',
      final c => '<$tag$renderedAttrs>${c.toHtml()}</$tag>',
    };
  }
}
