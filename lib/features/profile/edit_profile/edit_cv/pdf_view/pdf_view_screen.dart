//
//  @ Header: @Author: mary.mark@moselaymd.com | @CreateTime: ${createTime:YYYY-MM-DD HH:mm:ss} | @ModifiedBy: mary.mark@moselaymd.com | @ModifiedTime: ${modifyTime:YYYY-MM-DD HH:mm:ss}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/features/profile/edit_profile/edit_cv/edit_cv_controller.dart';
import 'package:para_job/packages/ui_components/show_snack_bar_message.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatelessWidget {
  PdfViewScreen({super.key});
  final String path = Get.find<EditCvController>().selectedCvPath ?? "";

  @override
  Widget build(BuildContext context) {
    final PdfViewerController pdfController = PdfViewerController();
    return Scaffold(
      appBar: AppBar(title: Text('pdf_viewer_title'.tr)),

      body: path.startsWith('http')
          ? SfPdfViewer.network(
              path,
              controller: pdfController,
              canShowScrollHead: true,
              canShowPaginationDialog: true,

              onDocumentLoadFailed: (details) {
                showSnackBarApiError();
              },

              canShowPageLoadingIndicator: true,
            )
          : SfPdfViewer.file(
              File(path),
              controller: pdfController,
              canShowScrollHead: true,
              canShowPaginationDialog: true,

              onDocumentLoadFailed: (details) {
                showSnackBarApiError();
              },
              canShowPageLoadingIndicator: true,
            ),
    );
  }
}
