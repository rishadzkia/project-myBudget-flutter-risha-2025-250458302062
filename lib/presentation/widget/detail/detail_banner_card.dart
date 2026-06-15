import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeatailBannerCard extends StatelessWidget {
  final String rekeningName;
  final String amount;
  final VoidCallback? onEditTap;

  const DeatailBannerCard({
    super.key,
    required this.rekeningName,
    required this.amount,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;

        return Container(
          height: cardWidth * 0.30,
          constraints: const BoxConstraints(
            minHeight: 105,
            maxHeight: 128,
          ),
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            cardWidth * 0.055,
            16,
            cardWidth * 0.045,
            16,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF0A477B),
                Color(0xFF0F68B8),
                Color(0xFF1688ED),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF59C1FF),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -12,
                bottom: -16,
                child: Opacity(
                  opacity: 0.28,
                  child: Image.asset(
                    'assets/home_page/pot.png',
                    width: cardWidth * 0.28,
                    height: cardWidth * 0.28,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.account_balance_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          rekeningName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          amount,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: onEditTap,
                        behavior: HitTestBehavior.opaque,
                        child: const Icon(
                          Icons.edit_square,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
