import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_category_dto.freezed.dart';
part 'news_category_dto.g.dart';

@freezed
class NewsCategoryDto with _$NewsCategoryDto {
  const factory NewsCategoryDto({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'name') required String name,
  }) = _NewsCategoryDto;

  factory NewsCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryDtoFromJson(json);
}

@freezed
class NewsCategoryListResponse with _$NewsCategoryListResponse {
  const factory NewsCategoryListResponse({
    @JsonKey(name: 'data') required List<NewsCategoryDto> data,
    @JsonKey(name: 'total') required int total,
  }) = _NewsCategoryListResponse;

  factory NewsCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryListResponseFromJson(json);
}
