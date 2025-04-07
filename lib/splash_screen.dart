import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/presentation/providers/auth_providerl.dart';
import 'main.dart';




class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    _redirectToNextScreen();
  }

Future<void> _redirectToNextScreen() async {
  await Future.delayed(const Duration(seconds: 3));

  final storedUser = box.read('user');

  print("=====${jsonEncode(storedUser)}=${storedUser}=");

  if (storedUser != null) {
  
    context.go('/home');
  } else {
    context.go('/login');
  }
}
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _animation,
        child: Center(
          child:FlutterLogo(size: 150)
        ),
      ),
    );
  }
}
