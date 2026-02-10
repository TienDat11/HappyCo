import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_video_dto.freezed.dart';
part 'news_video_dto.g.dart';

@freezed
class NewsVideoDto with _$NewsVideoDto {
  const factory NewsVideoDto({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'link_video') String? linkVideo,
    @JsonKey(name: 'createdAt') String? createdAt,
  }) = _NewsVideoDto;

  factory NewsVideoDto.fromJson(Map<String, dynamic> json) =>
      _$NewsVideoDtoFromJson(json);
}

@freezed
class NewsVideoListResponse with _$NewsVideoListResponse {
  const factory NewsVideoListResponse({
    @JsonKey(name: 'data') required List<NewsVideoDto> data,
    @JsonKey(name: 'total') required int total,
  }) = _NewsVideoListResponse;

  factory NewsVideoListResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsVideoListResponseFromJson(json);
}
