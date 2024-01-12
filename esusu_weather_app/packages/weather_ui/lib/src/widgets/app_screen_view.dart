import 'package:flutter/material.dart';

class AppScreenView extends StatelessWidget {
  const AppScreenView({
    Key? key,
    required this.body,
    this.background = const SizedBox(),
  }) : super(key: key);

  /// A body of the [AppScreenView]
  final Widget body;

  /// An optional background of the [AppScreenView]
  final Widget background;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        background,
        CustomScrollView(
         scrollBehavior: ScrollBehavior(),
          slivers: [
            SliverToBoxAdapter(child: body),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 200,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
