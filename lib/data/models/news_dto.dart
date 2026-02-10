import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

@freezed
class NewsCategoryRefDto with _$NewsCategoryRefDto {
  const factory NewsCategoryRefDto({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'name') required String name,
  }) = _NewsCategoryRefDto;

  factory NewsCategoryRefDto.fromJson(Map<String, dynamic> json) =>
      _$NewsCategoryRefDtoFromJson(json);
}

@freezed
class NewsDto with _$NewsDto {
  const factory NewsDto({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'category') NewsCategoryRefDto? category,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'isHighlight') bool? isHighlight,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'image') String? image,
  }) = _NewsDto;

  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);
}

@freezed
class NewsListResponse with _$NewsListResponse {
  const factory NewsListResponse({
    @JsonKey(name: 'data') required List<NewsDto> data,
    @JsonKey(name: 'total') required int total,
    @JsonKey(name: 'limit') int? limit,
    @JsonKey(name: 'offset') int? offset,
    @JsonKey(name: 'totalPages') int? totalPages,
    @JsonKey(name: 'currentPage') int? currentPage,
  }) = _NewsListResponse;

  factory NewsListResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsListResponseFromJson(json);
}
