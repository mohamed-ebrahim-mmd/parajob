import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
//import 'package:para_job/packages/constants/app_asset_paths.dart';

class IDImagePicker extends StatefulWidget {
  const IDImagePicker({super.key, required this.imagePath, required this.text});
  final String imagePath;
  final Widget text;

  @override
  State<IDImagePicker> createState() => _IDImagePickerState();
}

class _IDImagePickerState extends State<IDImagePicker> {
  File? _selectedImage; // holds the picked image file
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        padding: EdgeInsets.all(context.wPct(5)),
        width: context.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.pureWhite),
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Column(
          children: [
            _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(context.wPct(2)),
                    child: Image.file(
                      _selectedImage!,
                      width: context.wPct(60),
                      height: context.hPct(18),
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    widget.imagePath,
                    width: context.wPct(60),
                    height: context.hPct(18),
                    fit: BoxFit.contain,
                  ),

            context.hBox(0.5),
            widget.text

        
          ],
        ),
      ),
    );
  }
}
