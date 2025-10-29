import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class CVUploader extends StatefulWidget {
  const CVUploader({
    super.key,
    // required this.text,
    // this.isEducation = false,
  });

  // final Widget text;
  //final bool isEducation;

  @override
  State<CVUploader> createState() => _CVUploaderState();
}

class _CVUploaderState extends State<CVUploader> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _fileName = result.files.single.name;
        });
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //  onTap: _pickFile,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.hPct(4),
          horizontal: context.wPct(1),
        ),
        width: context.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.pureWhite),
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [..._buildContent(context)],
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    final fileWidget = _selectedFile != null
        ? Icon(
            Icons.check,
            color: AppColors.softWhite70,
            size: context.wPct(15),
          )
        : Image.asset(
            AppAssetPaths.cvUploadImg,
            // width: context.wPct(60),
            // height: context.hPct(18),
            fit: BoxFit.contain,
          );

    final textWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Drag your CV or\t",
          style: TextStyle(
            color: AppColors.softWhite70,
            fontSize: context.wPct(4),
          ),
        ),
        GestureDetector(
          onTap: _pickFile,
          child: Text(
            "click here",
            style: TextStyle(
              color: AppColors.pureWhite,
              decoration: TextDecoration.underline,
              fontSize: context.wPct(4),
            ),
          ),
        ),
        Text(
          "\tto upload",
          style: TextStyle(
            color: AppColors.softWhite70,
            fontSize: context.wPct(4),
          ),
        ),
      ],
    );
    final spacer = context.hBox(0.9);
    return [fileWidget, spacer, textWidget];
  }
}
