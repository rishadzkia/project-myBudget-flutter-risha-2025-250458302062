import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/auth/bloc/logout/logout_bloc.dart';
import 'package:my_budget/auth/pages/login_page.dart';

import 'package:my_budget/data/local/auth_local_datasource.dart';

import 'package:my_budget/presentation/page/lain/profile_edit_page.dart';

import 'package:my_budget/presentation/widget/dialog/logout_dialog.dart';
import 'package:my_budget/presentation/widget/profile/profile_avatar_card.dart';
import 'package:my_budget/presentation/widget/profile/profile_edit_button.dart';
import 'package:my_budget/presentation/widget/profile/profile_input_card.dart';
import 'package:my_budget/presentation/widget/profile/profile_logout_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                ),
              );
          },
          success: () {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Logout berhasil'),
                  backgroundColor: Color(0xFF2697E8),
                ),
              );

            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
              (route) => false,
            );
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF00233E),
          body: SafeArea(
            child: FutureBuilder(
              future: AuthLocalDatasource().getAuthData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Gagal mengambil data user',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  );
                }

                final authData = snapshot.data;

                final name = authData?.user?.name ?? 'User';
                final email = authData?.user?.email ?? '-';
                final firstName = name.split(' ').first;

                final nameController = TextEditingController(text: name);
                final emailController = TextEditingController(text: email);
                final birthDateController = TextEditingController(text: '-');
                final statusController = TextEditingController(text: '-');

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2697E8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Profil',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 42),
                        ],
                      ),
                      const SizedBox(height: 34),
                      ProfileAvatarCard(
                        imageUrl: null,
                        name: firstName,
                        email: email,
                      ),
                      const SizedBox(height: 18),
                      ProfileEditButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditProfilePage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      ProfileInputCard(
                        label: 'Nama',
                        controller: nameController,
                        icon: Icons.sell_outlined,
                        enabled: false,
                      ),
                      const SizedBox(height: 26),
                      ProfileInputCard(
                        label: 'Email',
                        controller: emailController,
                        icon: Icons.mail_outline_rounded,
                        enabled: false,
                      ),
                      const SizedBox(height: 26),
                      ProfileInputCard(
                        label: 'Tanggal lahir',
                        controller: birthDateController,
                        icon: Icons.calendar_month_outlined,
                        enabled: false,
                      ),
                      const SizedBox(height: 26),
                      ProfileInputCard(
                        label: 'Status',
                        controller: statusController,
                        icon: Icons.person,
                        enabled: false,
                      ),
                      const SizedBox(height: 32),
                      state.maybeWhen(
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                        orElse: () {
                          return ProfileLogoutButton(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (dialogContext) {
                                  return LogoutDialog(
                                    onLogout: () {
                                      context.read<LogoutBloc>().add(
                                            const LogoutEvent.logout(),
                                          );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
