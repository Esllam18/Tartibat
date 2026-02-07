import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';

class ImagePickerSection extends StatelessWidget {
  final List<String> images;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  const ImagePickerSection(
      {super.key,
      required this.images,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.photo_library_outlined,
                    color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Text('product_images'.tr(context),
                  style: AppTextStyles.h4(context)),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (c, i) => i == 0
                  ? _AddButton(onAdd)
                  : _ImageTile(images[i - 1], () => onRemove(i - 1)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddButton(this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6))
          ],
        ),
        child: const Icon(Icons.add_photo_alternate,
            color: Colors.white, size: 32),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final String url;
  final VoidCallback onRemove;
  const _ImageTile(this.url, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(url,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 100,
                    color: AppColors.background,
                    child: const Icon(Icons.broken_image,
                        color: AppColors.textSecondary)))),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
              child: const Icon(Icons.close, size: 16, color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}
