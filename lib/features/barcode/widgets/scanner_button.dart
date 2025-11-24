import 'package:flutter/material.dart';
import 'package:para_job/res/app_asset_paths.dart';
import 'package:para_job/features/barcode/scanner_screen.dart';
class ScannerButton extends StatefulWidget {
  final String title;
  final String iconPath;
  final ValueChanged<String>? onScanned;

  const ScannerButton({
    super.key,
    required this.title,
    this.iconPath = AppAssetPaths.barcodeScanIcon,
    this.onScanned,
  });

  @override
  State<ScannerButton> createState() => _ScannerButtonState();
}

class _ScannerButtonState extends State<ScannerButton> {
  String? barcode;

  void scanBarcode() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ScannerScreen()),
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        barcode = result;
      });
      widget.onScanned?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
          onPressed: scanBarcode,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(widget.iconPath, width: 20, height: 20),
              const SizedBox(width: 8),
              Text(widget.title),
            ],
          ),
        ),
      ],
    );
  }
}
