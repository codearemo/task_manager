import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickFile() async {
  try {
    XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    return xFile == null ? null : File(xFile.path);
    } catch (e) {
    return null;
  }
}
