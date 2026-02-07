import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProductDeleteDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const ProductDeleteDialog({super.key, this.onConfirm});

  static Future<void> show(BuildContext context, {VoidCallback? onConfirm}) {
    return showDialog(
      context: context,
      builder: (context) => ProductDeleteDialog(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Icon(Icons.warning, color: AppColors.error, size: 48),
      content: const Text(
        'Are you sure you want to delete this product?',
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
