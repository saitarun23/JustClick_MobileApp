import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class MooMascot extends StatefulWidget {
  const MooMascot({super.key, this.size = 72});
  final double size;

  @override
  State<MooMascot> createState() => _MooMascotState();
}

class _MooMascotState extends State<MooMascot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -5 * Curves.easeInOut.transform(_c.value)),
        child: child,
      ),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(painter: _MooPainter()),
      ),
    );
  }
}

class _MooPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.045
      ..strokeJoin = StrokeJoin.round
      ..color = AppColors.ink;

    Paint fill(Color c) => Paint()
      ..style = PaintingStyle.fill
      ..color = c;

    void blob(Rect r, Color c) {
      canvas.drawOval(r, fill(c));
      canvas.drawOval(r, line);
    }

    // Horns
    for (final dx in [0.30, 0.70]) {
      blob(
        Rect.fromCenter(
            center: Offset(s * dx, s * 0.13), width: s * 0.13, height: s * 0.17),
        AppColors.sun,
      );
    }

    // Ears
    for (final dx in [0.10, 0.90]) {
      blob(
        Rect.fromCenter(
            center: Offset(s * dx, s * 0.40), width: s * 0.24, height: s * 0.14),
        AppColors.pink,
      );
    }

    // Head with a black spot
    final head = Rect.fromCenter(
      center: Offset(s * 0.5, s * 0.54),
      width: s * 0.74,
      height: s * 0.70,
    );
    canvas.drawOval(head, fill(Colors.white));
    canvas.save();
    canvas.clipPath(Path()..addOval(head));
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(s * 0.30, s * 0.32), width: s * 0.28, height: s * 0.20),
      fill(AppColors.ink),
    );
    canvas.restore();
    canvas.drawOval(head, line);

    // Eyes
    for (final dx in [0.38, 0.62]) {
      canvas.drawCircle(Offset(s * dx, s * 0.50), s * 0.05, fill(AppColors.ink));
      canvas.drawCircle(
          Offset(s * (dx + 0.015), s * 0.485), s * 0.016, fill(Colors.white));
    }

    // Cheeks
    for (final dx in [0.27, 0.73]) {
      canvas.drawCircle(Offset(s * dx, s * 0.62), s * 0.05, fill(AppColors.pink));
    }

    // Snout
    blob(
      Rect.fromCenter(
          center: Offset(s * 0.5, s * 0.70), width: s * 0.38, height: s * 0.24),
      AppColors.pink,
    );
    for (final dx in [0.43, 0.57]) {
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(s * dx, s * 0.70), width: s * 0.045, height: s * 0.07),
        fill(AppColors.ink),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}