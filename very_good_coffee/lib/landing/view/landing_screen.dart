import 'package:coffee_ui/coffee_ui.dart';
import 'package:flutter/material.dart';

import '../widgets/landing_background.dart';
import '../widgets/landing_body.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LandingView(),
    );
  }
}

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScreenView(
      background: LandingBackground(),
      body: LandingBody(),
    );
  }
}
