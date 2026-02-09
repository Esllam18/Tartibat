import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class MediaService {
  static final _picker = ImagePicker();

  // Pick and compress image
  static Future<String?> pickImage({bool fromCamera = false}) async {
    try {
      final image = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image == null) return null;
      return await _compressImage(image.path);
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  // Pick video
  static Future<String?> pickVideo({bool fromCamera = false}) async {
    try {
      final video = await _picker.pickVideo(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxDuration: const Duration(minutes: 2),
      );

      if (video == null) return null;
      return await _saveVideo(video.path);
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

  // Pick multiple images
  static Future<List<String>> pickMultipleImages({int max = 5}) async {
    try {
      final images = await _picker.pickMultiImage(
          maxWidth: 1920, maxHeight: 1920, imageQuality: 85);
      final paths = <String>[];

      for (var image in images.take(max)) {
        final compressed = await _compressImage(image.path);
        if (compressed != null) paths.add(compressed);
      }

      return paths;
    } catch (e) {
      return [];
    }
  }

  // Compress and save image
  static Future<String?> _compressImage(String imagePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetPath = path.join(
        dir.path, 'media', '${DateTime.now().millisecondsSinceEpoch}.jpg');

    await Directory(path.dirname(targetPath)).create(recursive: true);

    final result = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      targetPath,
      quality: 80,
      minWidth: 1024,
      minHeight: 1024,
    );

    return result?.path;
  }

  // Save video
  static Future<String?> _saveVideo(String videoPath) async {
    final dir = await getApplicationDocumentsDirectory();
    final targetPath = path.join(
        dir.path, 'media', '${DateTime.now().millisecondsSinceEpoch}.mp4');

    await Directory(path.dirname(targetPath)).create(recursive: true);
    await File(videoPath).copy(targetPath);

    return targetPath;
  }

  // Delete media
  static Future<void> deleteMedia(String path) async {
    try {
      await File(path).delete();
    } catch (e) {
      print('Error deleting media: $e');
    }
  }
}
