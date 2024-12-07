import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> openGalleryLegacy() async {
  final ImagePicker picker = ImagePicker();
  final imageFile =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}

Future<File?> openCamera() async {
  final ImagePicker picker = ImagePicker();
  final imageFile =
      await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}

Future<List<File>?> openGallery() async {
  final ImagePicker picker = ImagePicker();
  List<XFile>? imageFiles = await picker.pickMultipleMedia(
    requestFullMetadata: true,
  );
  const validExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'mp4',
    'mov',
    'avi',
    'mkv'
  ];
  if (imageFiles.isNotEmpty) {
    List<File> files = imageFiles
        .where((xfile) {
          final ext = xfile.path.split('.').last.toLowerCase();
          return validExtensions.contains(ext);
        })
        .map((xfile) => File(xfile.path))
        .toList();

    return files.isNotEmpty ? files : null;
  }
  return null;
}
