class OnboardingPageData {
  final String titleKey, descriptionKey, imageUrl;
  const OnboardingPageData({
    required this.titleKey,
    required this.descriptionKey,
    required this.imageUrl,
  });
}

const onboardingPages = <OnboardingPageData>[
  OnboardingPageData(
    titleKey: 'onboarding_title_1',
    descriptionKey: 'onboarding_desc_1',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHjqlV6jEs_4naX1mPl2qhAwEiJfGqv1JgNA&s',
  ),
  OnboardingPageData(
    titleKey: 'onboarding_title_2',
    descriptionKey: 'onboarding_desc_2',
    imageUrl:
        'https://png.pngtree.com/thumb_back/fh260/background/20230525/pngtree-contemporary-living-room-with-modern-furniture-and-wooden-decor-3d-rendering-image_2618715.jpg',
  ),
  OnboardingPageData(
    titleKey: 'onboarding_title_3',
    descriptionKey: 'onboarding_desc_3',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaZIQRstQtL94C2xiZukeIoOCvp7bi9oFmww&s',
  ),
];
