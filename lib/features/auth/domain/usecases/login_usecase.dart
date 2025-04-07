import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user.dart';

final loginUseCaseProvider = Provider((ref) => LoginUseCase());


class LoginUseCase {
  Future<User> call(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@example.com' && password == '123456') {
      return User(email: email);
    } else {
      throw Exception("Invalid credentials");
    }
  }
}

