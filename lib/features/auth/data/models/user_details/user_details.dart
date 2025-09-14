import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/features/auth/domain/entities/user_details.dart';

part 'user_details.freezed.dart';
part 'user_details.g.dart';

@freezed
abstract class UserDetailsModel with _$UserDetailsModel {
  factory UserDetailsModel({
    required String username,
    required String email,
    required String avatarUrl,
  }) = _UserDetailsModel;

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsModelFromJson(json);

  factory UserDetailsModel.fromEntity(UserDetails userDetails) {
    return UserDetailsModel(
      username: userDetails.username,
      email: userDetails.email,
      avatarUrl: userDetails.avatarUrl,
    );
  }
}

extension UserDetailsModelEntity on UserDetailsModel {
  UserDetails toEntity() {
    return UserDetails(username: username, email: email, avatarUrl: avatarUrl);
  }
}
