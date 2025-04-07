import 'package:flutter/material.dart';

class SocialLoginOptions extends StatelessWidget {
  const SocialLoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.red,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.g_mobiledata),
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 20),
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.facebook),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
