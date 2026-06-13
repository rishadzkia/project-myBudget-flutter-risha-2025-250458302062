import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/presentation/widget/dialog/streak_dialog.dart';

class MaskotStreakProgress extends StatelessWidget {
  final int activeIndex;
  final List<String> labels;
  final ValueChanged<int>? onTapPoint;

  const MaskotStreakProgress({
    super.key,
    required this.activeIndex,
    required this.labels,
    this.onTapPoint,
  });

  void showStreakDialog(BuildContext context, String label) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (context) {
        return StreakDialog(
          streakLabel: label,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double dotSizeActive = 28;
    const double dotSizeNormal = 22;
    const double labelWidth = 48;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(labels.length * 2 - 1, (index) {
            final bool isDot = index % 2 == 0;

            if (!isDot) {
              return const Expanded(
                child: SizedBox(
                  height: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFF88C6F5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              );
            }

            final int dotIndex = index ~/ 2;
            final bool isActive = dotIndex == activeIndex;
            final double dotSize = isActive ? dotSizeActive : dotSizeNormal;

            return GestureDetector(
              onTap: () {
                if (onTapPoint != null) {
                  onTapPoint!(dotIndex);
                }

                showStreakDialog(
                  context,
                  labels[dotIndex],
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? const Color(0xFF57F000)
                      : const Color(0xFF88C6F5),
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFFB5FF8C)
                        : const Color(0xFF88C6F5),
                    width: 2,
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(0xFF57F000).withOpacity(0.45),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(labels.length, (index) {
            final bool isActive = index == activeIndex;

            return SizedBox(
              width: labelWidth,
              child: Text(
                labels[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
