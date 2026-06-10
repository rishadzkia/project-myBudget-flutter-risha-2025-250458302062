import 'package:flutter/material.dart';

class ProfileEditButton extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileEditButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFF002B4B),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.white.withOpacity(0.18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Edit Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 12),
            Icon(
              Icons.edit_square,
              color: Colors.white,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}
