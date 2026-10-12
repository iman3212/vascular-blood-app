import 'dart:io';
import 'package:vascular_blood/exports/modules.dart';


/// A controller class for managing a list of captured images.
/// This class uses [GetxController] to provide reactive state management
/// for a fixed-length list of image files.
class MainController extends GetxController {
  /// A reactive list of captured images.
  /// The list is initialized with a fixed length of 2, and each element is initially null.
  /// The list is non-growable, meaning its length cannot change after initialization.
  RxList<File?> capturedImages = List<File?>.filled(2, null, growable: false).obs;

  /// Adds an image to the [capturedImages] list at the specified index.
  /// 
  /// Parameters:
  /// - [index]: The index at which the image should be added.
  /// - [image]: The image file to be added.
  /// 
  /// Throws:
  /// - [ArgumentError] if the index is out of bounds.
  void addImage(int index, File image) {
    if (index >= 0 && index < capturedImages.length) {
      capturedImages[index] = image;
    } else {
      throw ArgumentError('Index out of bounds');
    }
  }

  /// Removes an image from the [capturedImages] list at the specified index.
  /// 
  /// Parameters:
  /// - [index]: The index from which the image should be removed.
  /// 
  /// Throws:
  /// - [ArgumentError] if the index is out of bounds.
  void removeImage(int index) {
    if (index >= 0 && index < capturedImages.length) {
      capturedImages[index] = null;
    } else {
      throw ArgumentError('Index out of bounds');
    }
  }

  /// Clears all images from the [capturedImages] list.
  /// Sets all elements in the list to null.
  void clearAllImages() {
    for (int i = 0; i < capturedImages.length; i++) {
      capturedImages[i] = null;
    }
  }

  /// Checks if all images in the [capturedImages] list have been captured.
  /// 
  /// Returns:
  /// - `true` if all elements in the list are non-null.
  /// - `false` otherwise.
  bool areAllImagesCaptured() {
    return capturedImages.every((image) => image != null);
  }

  /// Gets the number of non-null images in the [capturedImages] list.
  /// 
  /// Returns:
  /// - The count of non-null images.
  int getCapturedImagesCount() {
    return capturedImages.where((image) => image != null).length;
  }

  /// Saves all captured images to a specified directory.
  /// 
  /// Parameters:
  /// - [directoryPath]: The path to the directory where the images will be saved.
  /// 
  /// Throws:
  /// - [FileSystemException] if the directory cannot be created or accessed.
  Future<void> saveImagesToDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    for (int i = 0; i < capturedImages.length; i++) {
      final image = capturedImages[i];
      if (image != null) {
        final fileName = 'image_$i.png'; // Customize the file name as needed
        final filePath = '${directory.path}/$fileName';
        await image.copy(filePath);
      }
    }
  }

  /// Loads images from a specified directory into the [capturedImages] list.
  /// 
  /// Parameters:
  /// - [directoryPath]: The path to the directory from which the images will be loaded.
  /// 
  /// Throws:
  /// - [FileSystemException] if the directory cannot be accessed.
  Future<void> loadImagesFromDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);
    if (await directory.exists()) {
      final files = directory.listSync();
      for (int i = 0; i < capturedImages.length; i++) {
        final fileName = 'image_$i.png'; // Match the file name pattern used in `saveImagesToDirectory`
        final file = files.firstWhere(
          (file) => file.path.endsWith(fileName),
         // orElse: () => false,
        );
        if (file != null && file is File) {
          capturedImages[i] = file;
        }
      }
    }
  }

  /// Resets the [capturedImages] list to its initial state.
  /// Sets all elements in the list to null.
  void reset() {
    capturedImages.value = List<File?>.filled(2, null, growable: false);
  }
}