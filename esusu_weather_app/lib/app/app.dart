import 'package:flutter/material.dart';

import '../landing/view/landing_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///this will change depending on the variant you choose to build
      title: 'Variant: SRC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingScreen(),
    );
  }
}
