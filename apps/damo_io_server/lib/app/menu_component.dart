import 'package:damo_io_server/sources/source_link_presenter.dart';
import 'package:jaspr/jaspr.dart';

class MenuComponent extends StatelessComponent {
  final Iterable<SourceLinkPresenter> links;

  MenuComponent(this.links, {super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ul(
      classes: 'main-menu',
      links.map((it) => MenuListItemComponent(link: it)).toList(),
    );
  }
}

class MenuListItemComponent extends StatelessComponent {
  final SourceLinkPresenter link;

  MenuListItemComponent({super.key, required this.link});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final path = link.path();
    final label = link.source.name;
    final classes = link.isSelected ? 'selected' : null;

    yield li([
      a(href: path, classes: classes, [text(label)])
    ]);
  }
}
