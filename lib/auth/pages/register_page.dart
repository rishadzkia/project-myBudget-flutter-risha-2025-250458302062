import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/auth/bloc/login/login_bloc.dart';
import 'package:my_budget/auth/bloc/register/register_bloc.dart';
import 'package:my_budget/auth/pages/login_page.dart';
import 'package:my_budget/auth/pages/register_page.dart';
import 'package:my_budget/auth/widget/custom_button.dart';
import 'package:my_budget/auth/widget/custom_text_field.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/presentation/page/utama/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterBloc>().add(RegisterEvent.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.biru1,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: LoginBackgroundPainter(),
          ),
          SafeArea(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/splash/Group 43.png',
                  width: 140,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 36,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(74, 13, 38, 64),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.25), width: 1),
                  ),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daftar Akun',
                            style: GoogleFonts.righteous(
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Nama Lengkap',
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }
                              if (value.trim().length < 3) {
                                return 'Nama minimal 3 karakter';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CustomTextField(
                            hintText: 'Email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email tidak boleh kosong ya!';
                              }
                              if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$')
                                  .hasMatch(value.trim())) {
                                return 'Format email yang dimasukan tidak sesuai';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          CustomTextField(
                            hintText: 'Kata Sandi',
                            controller: _passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Kata Sandi Tidak Boleh Kosong';
                              }
                              if (value.length < 6) {
                                return 'Jumlah Kata Sandi Minimal 6 Karakter';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          // Buat pindah halaman
                          BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                              state.maybeWhen(
                                  orElse: () {},
                                  success: (data) async {
                                    await AuthLocalDatasource()
                                        .saveAuthData(data);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (_) => HomePage()));
                                  },
                                  error: (error) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(error),
                                      backgroundColor: Colors.red,
                                    ));
                                  });
                            },
                            child: BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                              return state.maybeWhen(
                                  orElse: () {
                                    return CustomButton(
                                      label: 'Daftar',
                                      onPressed: () {
                                        context.read<LoginBloc>().add(
                                            LoginEvent.login(
                                                email: _emailController.text,
                                                password:
                                                    _passwordController.text));
                                      },
                                    );
                                  },
                                  loading: () => Center(
                                        child: CircularProgressIndicator(),
                                      ));
                            }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sudah punya akun?',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                  child: Text(
                                    'Masuk Sekarang',
                                    style: GoogleFonts.poppins(
                                        color: AppColors.biru4,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) => LoginPage()));
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class LoginBackgroundPainter extends CustomPainter {
  const LoginBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF061D39),
          Color(0xFF03172D),
        ],
      ).createShader(Rect.fromLTWH(0, 0, width, height));

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final bluePaint = Paint()
      ..color = const Color(0xFF0C4677)
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = const Color(0xFF6EC6FF).withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    final topPath = Path()
      ..moveTo(width * 0.42, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height * 0.34)
      ..cubicTo(
        width * 0.96,
        height * 0.36,
        width * 0.88,
        height * 0.34,
        width * 0.84,
        height * 0.27,
      )
      ..cubicTo(
        width * 0.77,
        height * 0.15,
        width * 0.55,
        height * 0.15,
        width * 0.40,
        height * 0.10,
      )
      ..cubicTo(
        width * 0.27,
        height * 0.06,
        width * 0.30,
        height * 0.01,
        width * 0.42,
        0,
      )
      ..close();

    canvas.drawPath(topPath, glowPaint);
    canvas.drawPath(topPath, bluePaint);

    final bottomPath = Path()
      ..moveTo(0, height * 0.62)
      ..cubicTo(
        width * 0.30,
        height * 0.60,
        width * 0.58,
        height * 0.73,
        width * 0.62,
        height,
      )
      ..lineTo(0, height)
      ..close();

    canvas.drawPath(bottomPath, glowPaint);
    canvas.drawPath(bottomPath, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
