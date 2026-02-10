import 'package:happyco/data/models/news_video_dto.dart';
import 'package:happyco/domain/entities/news_entity.dart';

extension NewsVideoMapper on NewsVideoDto {
  NewsEntity toEntity() {
    return NewsEntity(
      id: id,
      title: title,
      description: '',
      imageUrl: '',
      publishDate: createdAt ?? '',
      category: NewsCategory.knowledge,
      videoUrl: linkVideo,
    );
  }
}

extension NewsVideoListMapper on NewsVideoListResponse {
  List<NewsEntity> toEntityList() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
