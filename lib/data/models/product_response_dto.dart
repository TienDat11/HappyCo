import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happyco/domain/entities/product_entity.dart';

part 'product_response_dto.freezed.dart';
part 'product_response_dto.g.dart';

/// Product Response Data Transfer Object
///
/// Represents the actual API response structure from /products?category={id}.
/// Matches MongoDB backend response format with nested objects.
@freezed
class ProductResponseDto with _$ProductResponseDto {
  const factory ProductResponseDto({
    /// MongoDB ObjectId for the product
    @JsonKey(name: '_id') required String id,

    /// Product display name
    required String name,

    /// Category ID (MongoDB ObjectId)
    String? category,

    /// Array of product images
    @JsonKey(name: 'listImage') List<ProductResponseImageDto>? listImage,

    /// Array of product color variants with pricing
    @JsonKey(name: 'productColors')
    List<ProductResponseColorDto>? productColors,

    /// Product status (e.g., "active", "inactive")
    String? status,
  }) = _ProductResponseDto;

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseDtoFromJson(json);
}

/// Product Image Data Transfer Object
///
/// Represents image data from API response listImage array.
@freezed
class ProductResponseImageDto with _$ProductResponseImageDto {
  const factory ProductResponseImageDto({
    /// Image URL path (relative to API base URL)
    String? url,

    /// MIME type of the image (e.g., "image/jpeg")
    String? mimetype,
  }) = _ProductResponseImageDto;

  factory ProductResponseImageDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseImageDtoFromJson(json);
}

/// Product Color Variant Data Transfer Object
///
/// Represents product color/variant from API response productColors array.
@freezed
class ProductResponseColorDto with _$ProductResponseColorDto {
  const factory ProductResponseColorDto({
    /// Price for this color variant
    required int price,

    /// Image URL for this color variant
    String? image,

    /// Nested color value object with code and name
    ProductColorValueDto? value,
  }) = _ProductResponseColorDto;

  factory ProductResponseColorDto.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseColorDtoFromJson(json);
}

/// Color Value Data Transfer Object
///
/// Represents nested color value object in productColors array.
@freezed
class ProductColorValueDto with _$ProductColorValueDto {
  const factory ProductColorValueDto({
    /// Hex color code (e.g., "#F5F5F5")
    String? code,

    /// Color name (e.g., "Trắng Sữa")
    String? name,
  }) = _ProductColorValueDto;

  factory ProductColorValueDto.fromJson(Map<String, dynamic> json) =>
      _$ProductColorValueDtoFromJson(json);
}

/// Extension to convert ProductResponseDto to ProductEntity
///
/// Provides mapping logic for API response to domain entity.
/// Handles nested objects and provides sensible defaults for optional fields.
extension ProductResponseMapper on ProductResponseDto {
  /// Converts API response DTO to domain ProductEntity
  ///
  /// Handles:
  /// - Nested image selection (uses first image)
  /// - Nested color variant selection (uses first color)
  /// - Category ID preservation
  /// - Optional fields with defaults
  ProductEntity toEntity() {
    // Get first image URL or use empty string fallback
    final firstImage =
        listImage?.isNotEmpty == true ? listImage!.first.url : '';
    final imageUrl = firstImage ?? '';

    // Get first color variant for pricing
    final firstColor =
        productColors?.isNotEmpty == true ? productColors!.first : null;
    final price = firstColor?.price ?? 0;

    return ProductEntity(
      id: id,
      name: name,
      priceInVnd: price,
      imageUrl: imageUrl,
      category: category,
      isFeatured: false, // API doesn't provide featured flag
    );
  }
}
