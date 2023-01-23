import 'package:flutter/material.dart';

class LandingBackground extends StatelessWidget {
  const LandingBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('landingScreen_background'),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Colors.brown,
            Colors.white,
          ],
          radius: 3,
        ),
      ),
    );
  }
}
