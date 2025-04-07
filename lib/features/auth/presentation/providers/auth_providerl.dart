import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/sources/auth_repository_impl.dart';
import '../../domain/entities/user.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl());

final authUserProvider = StateProvider<User?>((ref) => null);
