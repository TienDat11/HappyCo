import 'package:happyco/data/models/news_category_dto.dart';
import 'package:happyco/domain/entities/news_category_entity.dart';

extension NewsCategoryMapper on NewsCategoryDto {
  NewsCategoryEntity toEntity() {
    return NewsCategoryEntity(
      id: id,
      name: name,
    );
  }
}

extension NewsCategoryListMapper on NewsCategoryListResponse {
  List<NewsCategoryEntity> toEntityList() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
