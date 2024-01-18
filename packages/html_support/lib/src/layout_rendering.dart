import 'dart:io';

import 'html_presenter.dart';

class LayoutLoader {
  final _layouts = <String, Layout>{};

  Future<Layout> get(String path) async {
    if (!_layouts.containsKey(path)) {
      return await _loadLayout(path);
    }

    return _layouts[path]!;
  }

  Future<Layout> _loadLayout(String path) async {
    final content = await File(path).readAsString();
    final layout = Layout._from(content);

    _layouts[path] = layout;

    return layout;
  }
}

class Layout {
  final String _content;

  Layout._from(this._content);

  String render(Map<String, HtmlPresenter> content) {
    var rendered = _content;

    for (var entry in content.entries) {
      rendered = rendered.replaceFirst('<content id="${entry.key}"/>', entry.value.toHtml());
    }

    return rendered;
  }
}
