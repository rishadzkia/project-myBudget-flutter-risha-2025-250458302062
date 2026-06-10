import 'package:flutter/material.dart';
import 'package:my_budget/presentation/widget/profile/profile_avatar_card.dart';
import 'package:my_budget/presentation/widget/profile/profile_input_card.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
} 

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController birthDateController;
  late TextEditingController statusController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: 'Vyora zamora');
    emailController = TextEditingController(text: 'Vyorazamara@gmail.com');
    birthDateController = TextEditingController(text: '06 juni 2000');
    statusController = TextEditingController(text: 'Mahasiswa');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    birthDateController.dispose();
    statusController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 6, 6),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF47B6FF),
              onPrimary: Colors.white,
              surface: Color(0xFF00233E),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        birthDateController.text =
            '${selectedDate.day.toString().padLeft(2, '0')} '
            '${_monthName(selectedDate.month)} '
            '${selectedDate.year}';
      });
    }
  }

  String _monthName(int month) {
    const months = [
      'januari',
      'februari',
      'maret',
      'april',
      'mei',
      'juni',
      'juli',
      'agustus',
      'september',
      'oktober',
      'november',
      'desember',
    ];

    return months[month - 1];
  }

  void _saveProfile() {
    // Nanti bagian ini bisa kamu sambungkan ke API / Bloc
    final name = nameController.text;
    final email = emailController.text;
    final birthDate = birthDateController.text;
    final status = statusController.text;

    debugPrint('Nama: $name');
    debugPrint('Email: $email');
    debugPrint('Tanggal Lahir: $birthDate');
    debugPrint('Status: $status');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil berhasil disimpan'),
        backgroundColor: Color(0xFF2697E8),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00233E),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Edit Profil',
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
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const ProfileAvatarCard(
                    imageUrl: null,
                    name: 'Vyora',
                    email: 'Vyorazamara@gmail.com',
                  ),
                  Positioned(
                    right: 118,
                    bottom: 38,
                    child: GestureDetector(
                      onTap: () {
                        // nanti bisa pakai image_picker
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2697E8),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              ProfileInputCard(
                label: 'Nama',
                controller: nameController,
                icon: Icons.sell_outlined,
                enabled: true,
              ),
              const SizedBox(height: 26),
              ProfileInputCard(
                label: 'Email',
                controller: emailController,
                icon: Icons.mail_outline_rounded,
                enabled: true,
              ),
              const SizedBox(height: 26),
              ProfileInputCard(
                label: 'Tanggal lahir',
                controller: birthDateController,
                icon: Icons.calendar_month_outlined,
                enabled: true,
                onTap: _pickBirthDate,
              ),
              const SizedBox(height: 26),
              ProfileInputCard(
                label: 'Status',
                controller: statusController,
                icon: Icons.person,
                enabled: true,
              ),
              const SizedBox(height: 36),
              GestureDetector(
                onTap: _saveProfile,
                child: Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2697E8),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2697E8).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Simpan Perubahan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
