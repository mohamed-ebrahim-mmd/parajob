import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';
import 'package:para_job/packages/ui_components/app_network_image.dart';

import '../../job_details/complaint/widgets/company_complaint_bottom_sheet.dart';

class EmployerHeroSection extends StatelessWidget {
  final String? imageUrl;
  final int companyId;
  final String companyName;
  final bool companyIsSubmitComplaint;

  const EmployerHeroSection({
    super.key,
    this.imageUrl,
    required this.companyId,
    required this.companyName,
    required this.companyIsSubmitComplaint,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.hPct(30);
    return Stack(
      children: [
        CustomPaint(
          size: Size(double.infinity, height),
          painter: _BottomCurveShadowPainter(height),
        ),
        ClipPath(
          clipper: _BottomCurveClipper(height),
          child: Stack(
            children: [
              AppNetworkImage(
                url: imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: height,
              ),
              Container(
                width: double.infinity,
                height: height,
                color: Colors.black.withValues(alpha: 0.2),
              ),
            ],
          ),
        ),
        Positioned(
          top: context.hPct(3),
          right: context.wPct(4),
          child: IconButton(
            onPressed: () {
              showCompanyComplaintBottomSheet(
                companyName: companyName,
                companyId: companyId,
                companyIsSubmitComplaint: companyIsSubmitComplaint,
              );
            },
            icon: const Icon(Icons.more_vert, color: AppColors.pureWhite),
          ),
        ),

        Positioned(
          left: context.wPct(4),
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.pureWhite,
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomCurveClipper extends CustomClipper<Path> {
  final double height;

  _BottomCurveClipper(this.height);

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, height - height * 0.16);
    path.quadraticBezierTo(
      size.width / 2,
      height,
      size.width,
      height - height * 0.16,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _BottomCurveShadowPainter extends CustomPainter {
  final double height;

  _BottomCurveShadowPainter(this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.lineTo(0, height - height * 0.16);
    path.quadraticBezierTo(
      size.width / 2,
      height,
      size.width,
      height - height * 0.16,
    );
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawShadow(
      path,
      AppColors.aquaTeal.withAlpha((0.7 * 255).round()),
      10,
      true,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
