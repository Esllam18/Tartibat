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
      height: r.responsive(mobile: 260, tablet: 360, desktop: 440),
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(.18),
            blurRadius: 24,
            offset: const Offset(0, 14)),
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(fit: StackFit.expand, children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            memCacheHeight: 900,
            placeholder: (_, __) => const ColoredBox(color: Colors.black12),
            errorWidget: (_, __, ___) => const ColoredBox(
              color: Colors.black12,
              child: Center(child: Icon(Icons.image_not_supported_outlined)),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0x66000000), Color(0x00000000)],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
