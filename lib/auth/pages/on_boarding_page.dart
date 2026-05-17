import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnBoardingPageData> _pages = const [
    OnBoardingPageData(
      title:
          'Catat semua aktivitas keuanganmu agar lebih terkontrol dan tidak boros',
      imagePath: 'assets/onboard/cuate.png',
    ),
    OnBoardingPageData(
      title:
          'Atur pemasukan dan pengeluaranmu dalam satu aplikasi yang simpel dan rapi',
      imagePath: 'assets/onboard/rafiki.png',
    ),
    OnBoardingPageData(
      title:
          'Tentukan batas pengeluaran dan capai tujuan finansialmu dengan lebih terarah',
      imagePath: 'assets/onboard/rafiki2.png',
    ),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute<void>(builder: (_) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF49769F),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF7CBCE8),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(width, height * 0.50),
              painter: BottomDarkCurvePainter(),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/onboard/Frame 183.png',
              width: width,
              height: height * 0.68,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          Positioned(
            top: height * 0.28,
            left: 0,
            right: 0,
            height: height * 0.52,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Ilustrasi
                    SizedBox(
                      height: height * 0.36,
                      child: Image.asset(
                        _pages[index].imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Teks deskripsi: Ikut slide bersama gambar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Text(
                        _pages[index].title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          height: 1.25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: height * 0.115,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                final isActive = _currentPage == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 22 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: isActive
                        ? Colors.white
                        : Colors.white.withOpacity(0.45),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            left: 26,
            right: 26,
            bottom: height * 0.035,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF49769F),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    key: ValueKey<int>(_currentPage),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Painter kurva gelap bawah
class BottomDarkCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7CBCE8)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.27)
      ..quadraticBezierTo(
        size.width * 0.50,
        size.height * 0.02,
        size.width,
        size.height * 0.27,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Data Model
class OnBoardingPageData {
  final String title;
  final String imagePath;

  const OnBoardingPageData({required this.title, required this.imagePath});
}
