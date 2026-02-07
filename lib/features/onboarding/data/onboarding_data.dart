import 'package:flutter/material.dart';

class OnboardingPageData {
  final Widget image;
  final String titleKey;
  final String descriptionKey;

  const OnboardingPageData({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
}

const List<OnboardingPageData> onboardingPages = [
  OnboardingPageData(
    image: _FurnitureImage1(),
    titleKey: 'onboarding_title_1',
    descriptionKey: 'onboarding_desc_1',
  ),
  OnboardingPageData(
    image: _FurnitureImage2(),
    titleKey: 'onboarding_title_2',
    descriptionKey: 'onboarding_desc_2',
  ),
  OnboardingPageData(
    image: _FurnitureImage3(),
    titleKey: 'onboarding_title_3',
    descriptionKey: 'onboarding_desc_3',
  ),
];

class _FurnitureImage1 extends StatelessWidget {
  const _FurnitureImage1();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8B4513), Color(0xFFD2B48C)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(
        Icons.chair,
        size: 120,
        color: Colors.white70,
      ),
    );
  }
}

class _FurnitureImage2 extends StatelessWidget {
  const _FurnitureImage2();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2C2416), Color(0xFF8B4513)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(
        Icons.shopping_cart,
        size: 120,
        color: Colors.white70,
      ),
    );
  }
}

class _FurnitureImage3 extends StatelessWidget {
  const _FurnitureImage3();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFFD2B48C), Color(0xFF8B4513)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(
        Icons.home,
        size: 120,
        color: Colors.white70,
      ),
    );
  }
}
