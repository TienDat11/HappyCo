import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_dto.freezed.dart';
part 'banner_dto.g.dart';

@freezed
class BannerDto with _$BannerDto {
  const factory BannerDto({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'image') required String image,
    @JsonKey(name: 'actionUrl') String? actionUrl,
  }) = _BannerDto;

  factory BannerDto.fromJson(Map<String, dynamic> json) =>
      _$BannerDtoFromJson(json);
}

@freezed
class BannerListResponse with _$BannerListResponse {
  const factory BannerListResponse({
    @JsonKey(name: 'data') required List<BannerDto> data,
    @JsonKey(name: 'total') required int total,
  }) = _BannerListResponse;

  factory BannerListResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerListResponseFromJson(json);
}
