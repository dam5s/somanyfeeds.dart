import 'package:flutter/material.dart';

import 'articles_page.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 162, 113, 236);

    return MaterialApp(
      title: "damo.io — Damien Le Berrigaud's feeds.",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const ArticlesPage(),
    );
  }
}
