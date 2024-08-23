import 'package:jaspr/jaspr.dart';

class LayoutComponent extends StatelessComponent {
  final Component menu;
  final Iterable<Component> children;

  LayoutComponent({super.key, required this.menu, required this.children});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Document.head(
      title: 'damo.io - Damien Le Berrigaud\'s Feeds',
      meta: {
        'viewport': 'width=device-width, user-scalable=yes, initial-scale=1.0, minimum-scale=1.0',
      },
      children: [
        link(rel: 'stylesheet', type: 'text/css', href: '/reset.css'),
        link(rel: 'stylesheet', type: 'text/css', href: '/app.css'),
      ],
    );

    yield aside([
      h1([text('damo.io')]),
      menu,
    ]);

    yield* children;
  }
}
