import '../../../../core/network/api_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final baseUrl = 'https://reqres.in/api';

  @override
  Future<User> login(String email, String password) async {
    final data = await ApiService.post('$baseUrl/login', body: {
      'email': email,
      'password': password,
    });
    return UserModel(email: email); // Only called if success
  }

  @override
  Future<User> signup(String email, String password) async {
    final data = await ApiService.post('$baseUrl/register', body: {
      'email': email,
      'password': password,
    });
    return UserModel(email: email); // Only called if success
  }
}
