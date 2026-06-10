import 'package:flutter/material.dart';

class ProfileLogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileLogoutButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 51,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: const Color(0xFF1D3D59),
          borderRadius: BorderRadius.circular(9),
        ),
        child: const Row(
          children: [
            Text(
              'Keluar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Icon(
              Icons.logout_rounded,
              color: Color(0xFFFF5B5B),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}