import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';
import '../localization/app_localizations.dart';

class MediaPicker extends StatelessWidget {
  final List<String> paths;
  final Function(List<String>) onChanged;
  final bool allowVideo;
  final int maxMedia;

  const MediaPicker({
    super.key,
    required this.paths,
    required this.onChanged,
    this.allowVideo = true,
    this.maxMedia = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Media grid
        if (paths.isNotEmpty)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paths.length,
              itemBuilder: (_, i) => _buildThumbnail(context, i),
            ),
          ),
        const SizedBox(height: 12),

        // Add buttons
        Row(
          children: [
            if (paths.length < maxMedia)
              Expanded(
                child: _buildAddButton(
                  context,
                  icon: Icons.image,
                  label: 'add_image'.tr(context),
                  onTap: () => _pickImage(context),
                ),
              ),
            if (allowVideo && paths.isEmpty) ...[
              const SizedBox(width: 12),
              Expanded(
                child: _buildAddButton(
                  context,
                  icon: Icons.videocam,
                  label: 'add_video'.tr(context),
                  color: Colors.purple,
                  onTap: () => _pickVideo(context),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildThumbnail(BuildContext context, int index) {
    final path = paths[index];
    final isVideo = path.endsWith('.mp4') || path.endsWith('.mov');

    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: isVideo
                ? Center(
                    child: Icon(Icons.video_library,
                        size: 40, color: Colors.purple),
                  )
                : Image.file(File(path), fit: BoxFit.cover),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                final updated = List<String>.from(paths)..removeAt(index);
                onChanged(updated);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color color = Colors.blue,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.cairo(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        onChanged([...paths, image.path]);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('image_added_successfully'.tr(context)),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'error'.tr(context)}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _pickVideo(BuildContext context) async {
    try {
      final picker = ImagePicker();
      final video = await picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 2),
      );

      if (video != null) {
        onChanged([video.path]);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('video_added_successfully'.tr(context)),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'error'.tr(context)}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
