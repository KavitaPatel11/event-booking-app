import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user.dart';
final signupUseCaseProvider = Provider((ref) => SignupUseCase());
class SignupUseCase {
  Future<User> call(String email, String password, String confirmPassword) async {
    await Future.delayed(const Duration(seconds: 2));

    if (password != confirmPassword) throw Exception("Passwords do not match");
    if (!email.contains('@')) throw Exception("Invalid email format");

    return User(email: email);
  }
}