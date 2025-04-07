import 'dart:convert';

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/toast_util.dart';
import '../../../../core/widget/custum_textform_field.dart';
import '../../../../core/widget/social_login_button.dart';
import '../../../../main.dart';
import '../../domain/entities/user.dart';
import '../providers/auth_providerl.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String currentTab = "Login";
  bool _isLoading = false;

  Future<void> _loginOrSignup() async {
    if (_formKey.currentState!.validate()) {
      final authRepo = ref.read(authRepositoryProvider);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      setState(() => _isLoading = true); // show loader

      try {
        if (email == "demo@gmail.com" && password == "123456") {
          final User user = User(email: email);

          box.write('user', user);

          ref.read(authUserProvider.notifier).state = user;

          ToastUtil.showSuccess('Logged in as Demo User');
          setState(() => _isLoading = false);
          context.go('/home');
          return;
        }

        final user = currentTab == "Login"
            ? await authRepo.login(email, password)
            : await authRepo.signup(email, password);

        box.write('user', user); // assuming user is a Map or serializable

        ref.read(authUserProvider.notifier).state = user;

        currentTab == "Login"
            ? ToastUtil.showSuccess('Login Successfull')
            : ToastUtil.showSuccess('Registration Successfull');

        print("===user==${jsonEncode(user)}===");

        setState(() => _isLoading = false); // hide loader

        context.go('/home');
      } catch (e) {
        setState(() => _isLoading = false); // hide loader on error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                _buildSegmentedControl(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          CustomTextField(
                            label: "Email",
                            controller: _emailController,
                            icon: Icons.email,
                            validator: (v) => v == null || !v.contains('@')
                                ? 'Enter valid email'
                                : null,
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            label: "Password",
                            controller: _passwordController,
                            icon: Icons.security,
                            isPassword: true,
                            validator: (v) => v == null || v.length < 6
                                ? 'Min 6 characters'
                                : null,
                          ),
                          if (currentTab == "Signup") ...[
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Confirm Password",
                              controller: _confirmPasswordController,
                              icon: Icons.lock,
                              isPassword: true,
                              validator: (v) => v != _passwordController.text
                                  ? 'Passwords do not match'
                                  : null,
                            ),
                            const SizedBox(height: 10),
                          ],
                          if (currentTab == "Login") ...[
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text("Forgot password?"),
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _loginOrSignup,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                currentTab,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const SocialLoginOptions(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CustomSlidingSegmentedControl<String>(
        initialValue: currentTab,
        isStretch: true,
        innerPadding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(14),
        ),
        thumbDecoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        children: {
          "Login": Text(
            "Login",
            style: TextStyle(
              color: currentTab == "Login" ? Colors.white : Colors.black,
              fontWeight:
                  currentTab == "Login" ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          "Signup": Text(
            "Signup",
            style: TextStyle(
              color: currentTab == "Signup" ? Colors.white : Colors.black,
              fontWeight:
                  currentTab == "Signup" ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        },
        onValueChanged: (value) {
          setState(() => currentTab = value);
        },
      ),
    );
  }
}
