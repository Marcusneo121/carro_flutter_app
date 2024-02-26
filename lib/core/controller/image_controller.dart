import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class ImageController {
  final BuildContext context;
  final ImagePicker picker = ImagePicker();

  ImageController({required this.context}) {
    //write something for initialize
  }

  File xfileToFile(XFile xFile) {
    File? file = File(xFile.path);
    return file;
  }

  Future<XFile?> selectImageFromGallery() async {
    try {
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // return image;
        return await compressAndGetFile(image);
      } else {
        EasyLoading.showError("No image is selected, Please select an image");
        return null;
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong, please try again.");
      return null;
    }
  }

  Future<XFile?> compressAndGetFile(XFile file) async {
    try {
      EasyLoading.show();
      File xFileToFile = xfileToFile(file);
      final filePath = xFileToFile.absolute.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.png|.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

      var result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 88,
        format: CompressFormat.jpeg,
      );

      print(File(file.path).lengthSync());
      print(File(result?.path ?? "").lengthSync());

      if (result != null) {
        EasyLoading.dismiss();
        return result;
      } else {
        EasyLoading.showError(
            "Image compression failed, please try other photo.");
        return null;
      }
    } catch (e) {
      EasyLoading.showError(
          "Image compression failed, please try other photo.");
      return null;
    }
  }

  Future<List<XFile>?> selectMultipleImageFromGallery() async {
    // Pick multiple images.
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      return images;
    } else {
      EasyLoading.showError("No image is selected, Please select an image");
    }
  }

  // Future<String> uploadImage(File file) async {
  //   String fileName = file.path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     "file": await MultipartFile.fromFile(file.path, filename: fileName),
  //   });
  //   response = await dio.post("/info", data: formData);
  //   return response.data['id'];
  // }
}
