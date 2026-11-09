import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Turns a Google Images "imgres" page link into the real image link.
String resolveImageUrl(String raw) {
  final url = raw.trim();
  if (url.contains('google.com/imgres')) {
    final real = Uri.tryParse(url)?.queryParameters['imgurl'];
    if (real != null && real.isNotEmpty) return real;
  }
  return url;
}

class NetImage extends StatelessWidget {
  const NetImage({
    super.key,
    required this.url,
    this.fallbackIcon = Icons.image_outlined,
    this.background = AppColors.primarySoft,
    this.iconColor = AppColors.primary,
  });

  final String url;
  final IconData fallbackIcon;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final resolved = resolveImageUrl(url);

    final placeholder = ColoredBox(
      color: background,
      child: Center(child: Icon(fallbackIcon, color: iconColor, size: 30)),
    );

    if (!resolved.startsWith('http')) return placeholder;

    return Image.network(
      resolved,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return ColoredBox(
          color: background,
          child: const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stack) {
        debugPrint('IMAGE ERROR: $error\nURL: $resolved');
        return placeholder;
      },
    );
  }
}