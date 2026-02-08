import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class OnboardingImage extends StatelessWidget {
  final String imageUrl;

  const OnboardingImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      height: r.responsive(mobile: 280, tablet: 380, desktop: 460),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: r.spacing(8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              memCacheHeight: 1000,
              placeholder: (_, __) => Container(
                color: Colors.white.withOpacity(0.1),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
              errorWidget: (_, __, ___) => Container(
                color: Colors.white.withOpacity(0.1),
                child: const Icon(Icons.image_outlined,
                    color: Colors.white, size: 48),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
