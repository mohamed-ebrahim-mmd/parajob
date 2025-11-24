import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isEmulator = false;
  final controller = MobileScannerController();

  static const String emulatorValue =
      "https://para-jobs-be-staging.v4.mmd-technology.com/qr-code/99/0bbb50d8-0f49-492d-8d5f-ce35539cfa21";
  @override
  void initState() {
    super.initState();
    checkEmulator();
  }

  Future<void> checkEmulator() async {
    final info = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await info.androidInfo;
      isEmulator = !android.isPhysicalDevice;
    }

    if (Platform.isIOS) {
      final ios = await info.iosInfo;
      isEmulator = !ios.isPhysicalDevice;
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isEmulator) {
      return Scaffold(
        appBar: AppBar(title: const Text("Scan (Emulator Mode)")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, emulatorValue);
            },
            child: const Text("Return Emulator Value"),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Scan Barcode")),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final code = capture.barcodes.first.rawValue ?? "";
          Navigator.pop(context, code);
        },
      ),
    );
  }
}
