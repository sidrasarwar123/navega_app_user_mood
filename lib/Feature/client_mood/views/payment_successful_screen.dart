import 'dart:math';
import 'package:flutter/material.dart';
import 'package:navega_app/core/constants/app_color.dart';
import 'package:navega_app/core/constants/app_spacing.dart';
import 'package:navega_app/core/constants/textstyle.dart';
import 'package:navega_app/core/widgets/button/primary_button.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key});

  void _returnToHome(BuildContext context) {
    // Pop everything back to the first route (home).
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            children: [
              const Spacer(flex: 3),

              // ---- Dashed circle with check icon ----
              SizedBox(
                width: 96,
                height: 96,
                child: CustomPaint(
                  painter: _DashedCirclePainter(color: AppColors.success),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: AppColors.success,
                      size: 40,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Payment Successful',
                style: AppTextStyles.heading,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Payment Completed Successfully',
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 4),

              // ---- Return to home button ----
              PrimaryButton(
                label: 'Return to home',
                trailingIcon: Icons.arrow_forward,
                onPressed: () => _returnToHome(context),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Paints a dashed/segmented circle outline, similar to the design mock.
class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;
  final double gapDegrees;

  _DashedCirclePainter({
    required this.color,
    this.strokeWidth = 6,
    this.dashCount = 8,
    this.gapDegrees = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final sweepPerDash = (360 / dashCount) - gapDegrees;
    final stepAngle = 360 / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * stepAngle) * (pi / 180);
      final sweepAngle = sweepPerDash * (pi / 180);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter oldDelegate) => false;
}