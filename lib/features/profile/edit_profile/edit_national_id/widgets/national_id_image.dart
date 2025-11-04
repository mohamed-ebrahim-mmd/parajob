




import 'dart:io';
import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class NationalIdImg extends StatelessWidget {
  const NationalIdImg({
    super.key,
    required this.img,
    this.onEdit,
    this.localFile,
  });

  final String img; // initial network image
  final VoidCallback? onEdit;
  final File? localFile; // picked local file

  @override
  Widget build(BuildContext context) {
    final imageWidget = localFile != null
        ? Image.file(
            localFile!,
            width: double.infinity,
            height: context.hPct(30),
            fit: BoxFit.cover,
          )
        : Image.network(
            img,
            width: double.infinity,
            height: context.hPct(30),
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                 height: context.hPct(30),
                color: AppColors.lightGray,
                alignment: Alignment.center,
                child:  CircularProgressIndicator(strokeWidth: context.hPct(0.8),),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: context.hPct(30),
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child:  Icon(
                  Icons.broken_image_outlined,
                  size: context.wPct(50),
                  color: AppColors.lightGrey,
                ),
              );
            },
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(context.wPct(4)),
      child: Stack(
        children: [
          imageWidget,
          GestureDetector(
            onTap: onEdit,
            child: Container(
              width: double.infinity,
              height: context.hPct(30),
              color: Colors.black.withOpacity(0.6),
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: const Color(0x80FFFFFF),
                radius: context.wPct(7),
                child: const Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
