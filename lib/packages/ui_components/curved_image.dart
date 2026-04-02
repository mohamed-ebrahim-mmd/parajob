import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/app_colors.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class CurvedHeaderWithGlow extends StatelessWidget {
  final String imageUrl;
  final Widget? child;

  const CurvedHeaderWithGlow({super.key, required this.imageUrl, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // --- Curved shadow layer (green glow) ---
        PhysicalShape(
          clipper: BottomCurveClipper(),
          color: Colors.transparent,
          elevation: 20,
          // intensity of shadow
          shadowColor: Colors.tealAccent.withValues(alpha: 0.6),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: context.hPct(40),
            child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (bounds) {
                return LinearGradient(
                  // Use  opacity for the overlay
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: context.hPct(40),
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: context.hPct(40),
                  color: AppColors.aquaTealShadow,
                ),
              ),
            ),
          ),
        ),

        // --- Top icons (back + menu) ---
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.wPct(2)),
            child: child,
          ),
        ),
      ],
    );
  }
}

// --- Curved bottom clipper ---
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
