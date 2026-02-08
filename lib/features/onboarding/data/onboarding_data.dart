class OnboardingPageData {
  final String titleKey;
  final String descriptionKey;
  final String imageUrl;

  const OnboardingPageData({
    required this.titleKey,
    required this.descriptionKey,
    required this.imageUrl,
  });
}

const onboardingPages = [
  OnboardingPageData(
    titleKey: 'onboarding_title_1',
    descriptionKey: 'onboarding_desc_1',
    imageUrl:
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?q=80&w=1200&auto=format&fit=crop',
  ),
  OnboardingPageData(
    titleKey: 'onboarding_title_2',
    descriptionKey: 'onboarding_desc_2',
    imageUrl:
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=1200&auto=format&fit=crop',
  ),
  OnboardingPageData(
    titleKey: 'onboarding_title_3',
    descriptionKey: 'onboarding_desc_3',
    imageUrl:
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?q=80&w=1200&auto=format&fit=crop',
  ),
];
