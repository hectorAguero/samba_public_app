import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/app_localization_extension.dart';
import 'package:samba_public_app/extensions/theme_of_context_extension.dart';
import 'package:samba_public_app/main_logger.dart';
import 'package:transparent_image/transparent_image.dart';

class AppFadeInImage extends StatelessWidget {
  const AppFadeInImage(
    this.image, {
    this.height,
    this.width,
    this.fit,
    super.key,
  });

  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: image,
      imageErrorBuilder: (context, error, stackTrace) {
        debugLog('Error loading image: $error');
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colorScheme.error,
                context.colorScheme.errorContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                color: context.colorScheme.onError,
                size: 50,
              ), // Error icon
              Text(
                context.loc.errorLoadingImage,
                maxLines: 2,
                style: TextStyle(
                  color: context.colorScheme.onErrorContainer,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 4,
              ), // Space between text and error message
              Text(
                '$error',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
      fit: fit ?? BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
