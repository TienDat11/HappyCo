import 'package:happyco/data/models/product_dto.dart';
import 'package:happyco/domain/entities/product_entity.dart';

/// Product Mapper
///
/// Handles conversion between DTOs (data layer) and entities (domain layer).

extension ProductMapper on ProductDto {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      priceInVnd: priceInVnd,
      oldPriceInVnd: oldPriceInVnd,
      imageUrl: imageUrl,
      category: category,
      isFeatured: isFeatured,
    );
  }
}

extension ProductEntityMapper on ProductEntity {
  ProductDto toDto() {
    return ProductDto(
      id: id,
      name: name,
      priceInVnd: priceInVnd,
      oldPriceInVnd: oldPriceInVnd,
      imageUrl: imageUrl,
      category: category,
      isFeatured: isFeatured,
    );
  }
}

extension PaginatedProductMapper on PaginatedProductDto {
  List<ProductEntity> toEntityList() {
    return data.map((dto) => dto.toEntity()).toList();
  }
}
