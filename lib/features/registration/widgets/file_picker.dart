import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/res/app_asset_paths.dart';

class CVUploader extends StatefulWidget {
  const CVUploader({super.key, required this.onFileSelected});

  final ValueChanged<File?> onFileSelected;

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
        final file = File(result.files.single.path!);
        setState(() {
          _selectedFile = file;
          _fileName = result.files.single.name;
        });
        widget.onFileSelected(file);
      } else {
        widget.onFileSelected(null);
      }
    } catch (e) {
      log('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        height: context.hPct(20),
        padding: EdgeInsets.symmetric(
          vertical: context.hPct(3),
          horizontal: context.wPct(3),
        ),
        width: context.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.pureWhite),
          borderRadius: BorderRadius.circular(context.wPct(3)),
        ),
        child: CVContent(selectedFile: _selectedFile, fileName: _fileName),
      ),
    );
  }
}

class CVContent extends StatelessWidget {
  final File? selectedFile;
  final String? fileName;

  const CVContent({
    super.key,
    required this.selectedFile,
    required this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    final fileWidget = selectedFile != null
        ? Icon(
            Icons.check_circle,
            color: AppColors.aquaTeal,
            size: context.wPct(15),
          )
        : Image.asset(
            AppAssetPaths.cvUploadImg,
            fit: BoxFit.contain,
            //width: context.wPct(30),
          );

    final textWidget = selectedFile != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fileName ?? "File selected",
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontSize: context.wPct(3.8),
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Click here to upload CV",
                style: TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.w600,
                  fontSize: context.wPct(4),
                ),
              ),
            ],
          )
        : Text(
            "Click here to upload CV",
            style: TextStyle(
              color: AppColors.softWhite70,
              fontWeight: FontWeight.w500,
              fontSize: context.wPct(4),
            ),
          );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [fileWidget, context.hBox(1), textWidget],
    );
  }
}
