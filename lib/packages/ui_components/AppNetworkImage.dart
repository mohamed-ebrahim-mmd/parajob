import 'package:flutter/material.dart';
import 'package:para_job/packages/themeing/media_query_values.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final double imgWidth = width ?? context.wPct(12);
    final double imgHeight = height ?? context.wPct(12);

    final border = borderRadius ?? BorderRadius.circular(0);

    return ClipRRect(
      borderRadius: border,
      child: Image.network(
        url ?? "",
        width: imgWidth,
        height: imgHeight,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ??
              Container(
                width: imgWidth,
                height: imgHeight,
                alignment: Alignment.center,
                color: Colors.grey.shade100,
                child: const CircularProgressIndicator(strokeWidth: 2),
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: imgWidth,
                height: imgHeight,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                ),
              );
        },
      ),
    );
  }
}
