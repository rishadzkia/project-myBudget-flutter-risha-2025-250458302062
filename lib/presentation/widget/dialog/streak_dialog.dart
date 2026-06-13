import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StreakDialog extends StatelessWidget {
  final String streakLabel;

  const StreakDialog({
    super.key,
    required this.streakLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 34),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 350,
            margin: const EdgeInsets.symmetric(horizontal: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const RadialGradient(
                center: Alignment(-2, -0.85),
                radius: 1.8,
                colors: [
                  Color(0xFF79C9FF),
                  Color(0xFF1C5EA3),
                  Color(0xFF062B68),
                  Color(0xFF4FA7ED),
                  Color(0xFF001744),
                ],
                stops: [
                  0.0,
                  0.22,
                  0.48,
                  0.72,
                  1.0,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 22,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 28,
                  right: 30,
                  child: StreakBubble(
                    size: 62,
                    opacity: 0.42,
                  ),
                ),
                Positioned(
                  top: 168,
                  left: 28,
                  child: StreakBubble(
                    size: 32,
                    opacity: 0.38,
                  ),
                ),
                Positioned(
                  right: 24,
                  bottom: 86,
                  child: StreakBubble(
                    size: 56,
                    opacity: 0.34,
                  ),
                ),
                // Positioned(
                //   top: 42,
                //   left: 0,
                //   right: 0,
                //   child: Text(
                //     'Selamat',
                //     textAlign: TextAlign.center,
                //     style: GoogleFonts.righteous(
                //       color: Colors.black,
                //       fontSize: 40,
                //       fontWeight: FontWeight.w900,
                //       letterSpacing: 2.5,
                //       height: 1,
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFFFFA000).withOpacity(0.32),
                                blurRadius: 28,
                                spreadRadius: 6,
                              ),
                              BoxShadow(
                                color:
                                    const Color(0xFFFF6D00).withOpacity(0.22),
                                blurRadius: 46,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/maskot/fire.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 34,
                  bottom: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/maskot/maskot_oke.png',
                        width: 82,
                        height: 82,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          streakLabel,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF5BC8F5),
                            fontSize: 55,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StreakBubble extends StatelessWidget {
  final double size;
  final double opacity;

  const StreakBubble({
    super.key,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 0.95,
          colors: [
            Colors.white.withOpacity(opacity),
            Colors.white.withOpacity(opacity * 0.45),
            const Color(0xFF0C2F67).withOpacity(0.35),
          ],
          stops: const [
            0.0,
            0.55,
            1.0,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            blurRadius: 12,
            offset: const Offset(6, 8),
          ),
        ],
      ),
    );
  }
}
