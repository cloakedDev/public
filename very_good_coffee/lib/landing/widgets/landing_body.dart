import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../bloc/coffee_cubit.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeeCubit>(
      key: const Key('landing_Body'),
      create: (context) => CoffeeCubit()..grabCoffeeImage(),
      child: BlocBuilder<CoffeeCubit, CoffeeState>(
        builder: (context, state) {
          if (state is CoffeeLoading) {
            return Platform.isAndroid
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const CupertinoActivityIndicator(
                    color: Colors.white,
                  );
          } else if (state is CoffeeLoaded) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Stack(
                  children: [
                    /// Coffee image from api
                    /// tap once to load a new image
                    /// tap twice to "favorite"
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => context.read<CoffeeCubit>().refresh(),
                            onDoubleTap: () async {
                              String url = state.image;
                              await GallerySaver.saveImage(url,
                                  albumName: 'Very Good Coffee');
                            },
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: state.image,
                                  progressIndicatorBuilder: (context, url,
                                          progress) =>
                                      Platform.isAndroid
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.black,
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// Help button
                    /// Shows an alert to explain how to use
                    /// the features
                    Positioned(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () => helpInfoAlert(context),
                          style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all(const CircleBorder()),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.brown), // <-- Button color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.brown[700];
                              } // <-- Splash color
                            }),
                          ),
                          child: const Icon(Icons.help_outline),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is CoffeeError) {
            return Column(
              children: const [
                Icon(Icons.error),
                Text('An error has occurred. Please try again.')
              ],
            );
          }
          return Column();
        },
      ),
    );
  }
}

/// Alert: Shows instructions on how to use the app
helpInfoAlert(BuildContext context) {
  dynamic alert;

  /// set up the button
  Widget okButton = TextButton(
    child: const Text("Ok"),
    onPressed: () => Navigator.of(context).pop(),
  );

  // set up the AlertDialog
  if (Platform.isIOS) {
    alert = CupertinoAlertDialog(
      title: const Text("Help"),
      content: const Text(
          "\nTap Once: Load another coffee image. \n\nTap Twice: Save image locally to device."),
      actions: [
        okButton,
      ],
    );
  } else {
    alert = AlertDialog(
      title: const Text("Attention"),
      content: const Text(
          "\nTap Once: Load another coffee image. \n\nTap Twice: Save image locally to device."),
      actions: [
        okButton,
      ],
    );
  }

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
