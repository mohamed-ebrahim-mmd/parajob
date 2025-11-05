

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatelessWidget {
  final String path;

  const PdfViewerPage({super.key, required this.path});

  Future<PdfControllerPinch> _loadController() async {
    PdfDocument document;

    if (path.startsWith('http')) {
      final response = await http.get(Uri.parse(path));
      if (response.statusCode != 200) {
        throw Exception('Failed to load PDF from URL');
      }
      Uint8List bytes = response.bodyBytes;
      document = await PdfDocument.openData(bytes);
    } else {
      document = await PdfDocument.openFile(path);
    }

    return PdfControllerPinch(document: Future.value(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: FutureBuilder<PdfControllerPinch>(
        future: _loadController(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading PDF 😕',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            return PdfViewPinch(
              controller: snapshot.data!,
              builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                options: const DefaultBuilderOptions(),
                documentLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                pageLoaderBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
                errorBuilder: (_, error) => Center(
                  child: Text(
                    'Error loading PDF 😕',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('Unknown error occurred'));
          }
        },
      ),
    );
  }
}
