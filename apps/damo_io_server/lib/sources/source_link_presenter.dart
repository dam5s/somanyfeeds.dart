import 'package:damo_io_server/sources/source.dart';

class SourceLinkPresenter {
  static final _defaultSources = [Source.about, Source.social, Source.blog];

  static String defaultPath = _path(_defaultSources);

  static Source? _tryParse(String value) => //
      switch (value) {
        'about' => Source.about,
        'social' => Source.social,
        'code' => Source.code,
        'blog' => Source.blog,
        String() => null,
      };

  static Set<Source>? tryParsePath(String path) {
    final mapped = path.split(',').map(_tryParse);

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

  String path() {
    final targetSources = switch (isSelected) {
      true => Source.values.where((it) => it != source && selected.contains(it)),
      false => Source.values.where((it) => it == source || selected.contains(it)),
    };

    return _path(targetSources);
  }

  static String _path(Iterable<Source> sources) {
    return '/${sources.map((it) => it.name).join(',')}';
  }
}
