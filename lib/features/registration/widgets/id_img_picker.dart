import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:para_job/features/job_details/complaint/widgets/complaint_item.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class IdImagePicker extends StatefulWidget {
  const IdImagePicker({
    super.key,
    required this.imagePath,
    required this.text,
    this.isEducation = false,
    required this.onImageSelected, // 👈 add this
    this.cameraOption = true,
    this.galleryOption = true,
  });

  final String imagePath;
  final Widget text;
  final bool isEducation;
  final ValueChanged<File?> onImageSelected; // 👈 callback to parent
  final bool cameraOption;
  final bool galleryOption;

  @override
  State<IdImagePicker> createState() => _IdImagePickerState();
}

class _IdImagePickerState extends State<IdImagePicker> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  void showTakePhotoOptionsBottomSheet() {
    final context = Get.context!;

    Get.bottomSheet(
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.midnightBlue,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.wPct(6)),
          ),
        ),
        padding: EdgeInsets.all(context.wPct(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.cameraOption
                ? ComplaintItem(
                    title: '${'take_photo'.tr} ',
                    onTap: () {
                      Get.back();
                      _pickImage(fromCamera: true);
                    },
                  )
                : SizedBox(),
            context.hBox(2),
            widget.galleryOption
                ? ComplaintItem(
                    title: '${'choose_photo'.tr} ',
                    onTap: () {
                      Get.back();
                      _pickImage();
                    },
                  )
                : SizedBox(),
            context.hBox(2),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _pickImage({bool fromCamera = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,

        imageQuality: 85,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        setState(() => _selectedImage = file);
        widget.onImageSelected(file); // 👈 notify parent
      } else {
        widget.onImageSelected(null); // 👈 user cancelled
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showTakePhotoOptionsBottomSheet,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.hPct(2),
          horizontal: context.wPct(1),
        ),
        width: context.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.pureWhite),
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: IDImageContent(
          selectedImage: _selectedImage,
          imagePath: widget.imagePath,
          text: widget.text,
          isEducation: widget.isEducation,
        ),
      ),
    );
  }
}

class IDImageContent extends StatelessWidget {
  final File? selectedImage;
  final String imagePath;
  final Widget text;
  final bool isEducation;

  const IDImageContent({
    super.key,
    required this.selectedImage,
    required this.imagePath,
    required this.text,
    required this.isEducation,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = selectedImage != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(context.wPct(2)),
            child: Image.file(
              selectedImage!,
              width: context.wPct(90),
              height: context.hPct(18),
              fit: BoxFit.contain,
            ),
          )
        : Image.asset(
            imagePath,
            width: context.wPct(90),
            height: context.hPct(18),
            fit: BoxFit.contain,
          );

    final spacer = context.hBox(0.5);

    if (isEducation) {
      return Column(children: [text, spacer, imageWidget]);
    } else {
      return Column(children: [imageWidget, spacer, text]);
    }
  }
}
