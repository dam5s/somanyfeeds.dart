import 'package:jaspr/jaspr.dart';

class LayoutComponent extends StatelessComponent {
  final Iterable<Component> children;

  LayoutComponent(this.children, {super.key});

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

    yield* children;

    yield script([], src: '/htmx-2.0.2.min.js');
  }
}
