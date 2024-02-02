import 'package:damo_io_server/sources/source.dart';
import 'package:html_support/html_support.dart';

class SourceLinkPresenter extends HtmlPresenter {
  static final _defaultSources = [Source.about, Source.social, Source.blog];

  static String path(Iterable<Source> sources) {
    return '/${sources.map((it) => it.name).join(',')}';
  }

  static String defaultPath = path(_defaultSources);

  static Set<Source>? tryParsePath(String path) {
    Source? tryParse(String value) => switch (value) {
          'about' => Source.about,
          'social' => Source.social,
          'code' => Source.code,
          'blog' => Source.blog,
          String() => null,
        };

    final mapped = path.split(',').map(tryParse);

    if (mapped.any((src) => src == null)) {
      return null;
    }

    return mapped.nonNulls.toSet();
  }

  final Source source;
  final Set<Source> selected;
  final bool isSelected;

  SourceLinkPresenter({required this.source, required this.selected})
      : isSelected = selected.contains(source);

  @override
  String toHtml() {
    final attributes = switch (isSelected) {
      true => {'href': _path(), 'class': 'selected'},
      false => {'href': _path()},
    };

    return a(attrs: attributes, text: source.name).toHtml();
  }

  String _path() {
    final targetSources = switch (isSelected) {
      true => Source.values.where((it) => it != source && selected.contains(it)),
      false => Source.values.where((it) => it == source || selected.contains(it)),
    };

    return path(targetSources);
  }
}
