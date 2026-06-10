import 'package:flutter/material.dart';

class ProfileAvatarCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String email;

  const ProfileAvatarCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 104,
          height: 104,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Color(0xFF47B6FF),
                width: 2,
              ),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null
                ? const Icon(
                    Icons.person,
                    size: 76,
                    color: Colors.black,
                  )
                : null,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          email,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}