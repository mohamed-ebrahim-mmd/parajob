import 'package:flutter/material.dart';

class CurvedImageWithShadow extends StatelessWidget {
  final String imageUrl;
  final double height;
  final Color shadowColor;
  final Widget? child;

  const CurvedImageWithShadow({
    super.key,
    required this.imageUrl,
    this.height = 260,
    this.shadowColor = const Color.fromARGB(255, 20, 181, 69),
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// === Image with curved bottom and dark overlay ===
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              // overlay to darken image
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: child == null ? null : Center(child: child),
            ),
          ),
        ),
      ],
    );
  }
}

/// Curve for image bottom
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
