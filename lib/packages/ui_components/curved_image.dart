import 'package:flutter/material.dart';

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
          elevation: 20, // intensity of shadow
          color: Colors.transparent,
          shadowColor: Colors.tealAccent.withOpacity(0.6),
          child: Container(height: 250, color: Colors.transparent),
        ),

        // --- Main image with curved bottom ---
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
            //  Center(child: Icon(Icons.broken_image, color: Colors.grey)),
          ),
        ),

        // --- Optional overlay for dark effect on image ---
        ClipPath(
          clipper: BottomCurveClipper(),
          child: Container(height: 250, color: Colors.black.withOpacity(0.3)),
        ),

        // --- Top icons (back + menu) ---
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
