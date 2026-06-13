import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/widget/level/level_message_card.dart';
import 'package:my_budget/presentation/widget/level/level_month_card.dart';
import 'package:my_budget/presentation/widget/level/level_streak_progress.dart';

class MaskotPage extends StatefulWidget {
  const MaskotPage({super.key});

  @override
  State<MaskotPage> createState() => _MaskotPageState();
}

class _MaskotPageState extends State<MaskotPage> {
  int bulanAktif = 5;
  int streakAktif = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.biru1,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Level',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/home_page/Elipse.68.png',
              width: 320,
              fit: BoxFit.contain,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/maskot/maskot_oke.png',
                    width: 240,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20),
                  LevelMessageCard(
                    title: 'Kamu Luar Biasa',
                    subtitle: 'Pertahankan Kebiasaan Baikmu',
                  ),
                  SizedBox(height: 16),
                  LevelMonthCard(selectedMonthIndex: bulanAktif),
                  SizedBox(height: 30),
                  MaskotStreakProgress(
                    activeIndex: streakAktif,
                    labels: [
                      '+10',
                      '+50'
                          '+100',
                      '+200',
                    ],
                    onTapPoint: (index) {
                      setState(() {
                        streakAktif = index;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
