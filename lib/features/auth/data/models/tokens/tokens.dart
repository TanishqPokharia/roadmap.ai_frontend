import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:roadmap_ai/features/auth/domain/entities/tokens.dart';

part 'tokens.freezed.dart';
part 'tokens.g.dart';

@freezed
abstract class TokensModel with _$TokensModel {
  factory TokensModel({
    required String accessToken,
    required String refreshToken,
  }) = _TokensModel;

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);

  factory TokensModel.fromEntity(Tokens tokens) {
    return TokensModel(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }
}

extension TokensModelEntity on TokensModel {
  Tokens toEntity() {
    return Tokens(accessToken: accessToken, refreshToken: refreshToken);
  }
}
