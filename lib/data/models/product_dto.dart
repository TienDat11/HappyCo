import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

/// Product Data Transfer Object
///
/// Represents product data from API response.
@JsonSerializable()
class ProductDto {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'price_in_vnd')
  final int priceInVnd;
  @JsonKey(name: 'old_price_in_vnd')
  final int? oldPriceInVnd;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'category')
  final String? category;
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @JsonKey(name: 'stock')
  final int? stock;
  @JsonKey(name: 'sold')
  final int? sold;
  @JsonKey(name: 'rating')
  final double? rating;
  @JsonKey(name: 'total_reviews')
  final int? totalReviews;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'sku')
  final String? sku;

  ProductDto({
    required this.id,
    required this.name,
    required this.priceInVnd,
    this.oldPriceInVnd,
    required this.imageUrl,
    this.category,
    required this.isFeatured,
    this.stock,
    this.sold,
    this.rating,
    this.totalReviews,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.sku,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}

/// Paginated Product List Response
///
/// Represents paginated list of products from API.
@JsonSerializable()
class PaginatedProductDto {
  @JsonKey(name: 'data')
  final List<ProductDto> data;
  @JsonKey(name: 'total')
  final int total;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'page_size')
  final int? pageSize;

  PaginatedProductDto({
    required this.data,
    required this.total,
    this.page,
    this.pageSize,
  });

  factory PaginatedProductDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedProductDtoToJson(this);
}
