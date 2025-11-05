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
      appBar: AppBar(title: const Text('PDF Viewer')),

      body: path.isEmpty
          ? const Center(
              child: Text(
                "❌ No PDF file selected.",
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            )
          : path.startsWith('http')
          ? SfPdfViewer.network(
              path,
              controller: pdfController,
              canShowScrollHead: true,
              canShowPaginationDialog: true,
              onDocumentLoaded: (details) {
                debugPrint(
                  'Document loaded with ${details.document.pages.count} pages',
                );
              },
              onDocumentLoadFailed: (details) {
                showSnackBarApiError();
              },
              onPageChanged: (details) {
                debugPrint('Page changed: ${details.newPageNumber}');
              },

              canShowPageLoadingIndicator: true,
            )
          : SfPdfViewer.file(
              File(path),
              controller: pdfController,
              canShowScrollHead: true,
              canShowPaginationDialog: true,
              onDocumentLoaded: (details) {
                debugPrint('Loaded ${details.document.pages.count} pages');
              },
              onDocumentLoadFailed: (details) {
                showSnackBarApiError();
              },
              canShowPageLoadingIndicator: true,
            ),
    );
  }
}
