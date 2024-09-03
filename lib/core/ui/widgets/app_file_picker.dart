import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:task_manager/core/theme/app_parllete.dart';
import 'package:task_manager/core/utils/app_file_picker.dart';

class AppFilePicker extends StatefulWidget {
  const AppFilePicker({
    super.key,
    required this.onSelectFile,
  });

  final void Function(File?) onSelectFile;

  @override
  State<AppFilePicker> createState() => _AppFilePickerState();
}

class _AppFilePickerState extends State<AppFilePicker> {
  File? selectedImage;

  void selectImage() async {
    selectedImage = await pickFile();
    if (selectedImage != null) {
      widget.onSelectFile(selectedImage);
      setState(() {});
    }
  }

  removeImage() {
    widget.onSelectFile(null);
    setState(() {
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          color: AppPallete.borderColor,
          dashPattern: const [10, 4],
          radius: const Radius.circular(12),
          borderType: BorderType.RRect,
          strokeCap: StrokeCap.round,
          child: selectedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    selectedImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                )
              : InkWell(
                  onTap: selectImage,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Select your image',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        if (selectedImage != null) ...[
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: removeImage,
            child: const Text(
              'Remove Image',
              style: TextStyle(
                color: AppPallete.errorColor,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
