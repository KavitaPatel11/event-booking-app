import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
   
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    
        'email': email,
      };
}
