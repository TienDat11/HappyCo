import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:happyco/data/models/product_response_dto.dart';

part 'product_dto.freezed.dart';
part 'product_dto.g.dart';

/// Product Data Transfer Object
///
/// Represents product data from API response using freezed for immutability.
@freezed
class ProductDto with _$ProductDto {
  const factory ProductDto({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? category,
    int? quantity,
    @JsonKey(name: 'sold_quantity') int? soldQuantity,
    String? code,
    String? unit,
    @JsonKey(name: 'productColors') List<ProductColorDto>? productColors,
    @JsonKey(name: 'listImage') List<ProductImageDto>? listImage,
    String? status,
    bool? hot,
    @JsonKey(name: 'statusWarehouse') String? statusWarehouse,
  }) = _ProductDto;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  /// Creates ProductDto from ProductResponseDto
  ///
  /// Maps the actual API response structure to the internal DTO structure.
  /// This bridges the gap between API response and domain models.
  factory ProductDto.fromProductResponse(ProductResponseDto response) {
    // Convert listImage array
    final images = response.listImage
            ?.map((img) => ProductImageDto(
                  id: '', // API doesn't provide image ID
                  name: null,
                  url: img.url ?? '',
                ))
            .toList() ??
        [];

    // Convert productColors array
    final colors = response.productColors
            ?.map((color) => ProductColorDto(
                  id: '', // API doesn't provide color variant ID
                  price: color.price,
                  image: color.image,
                ))
            .toList() ??
        [];

    return ProductDto(
      id: response.id,
      name: response.name,
      category: response.category,
      listImage: images,
      productColors: colors,
      status: response.status,
      hot: null, // API doesn't provide hot flag
      quantity: null, // API doesn't provide quantity
      soldQuantity: null, // API doesn't provide soldQuantity
      code: null, // API doesn't provide code
      unit: null, // API doesn't provide unit
      statusWarehouse: null, // API doesn't provide statusWarehouse
    );
  }
}

/// Product Color/Variant Data Transfer Object
///
/// Represents product color/variant data from API response.
@freezed
class ProductColorDto with _$ProductColorDto {
  const factory ProductColorDto({
    @JsonKey(name: '_id') required String id,
    required int price,
    @JsonKey(name: 'price_listed') int? priceListed,
    @JsonKey(name: 'price_selling') int? priceSelling,
    int? quantity,
    String? image,
    String? barcode,
  }) = _ProductColorDto;

  factory ProductColorDto.fromJson(Map<String, dynamic> json) =>
      _$ProductColorDtoFromJson(json);
}

/// Product Image Data Transfer Object
///
/// Represents product image data from API response.
@freezed
class ProductImageDto with _$ProductImageDto {
  const factory ProductImageDto({
    @JsonKey(name: '_id') required String id,
    String? name,
    required String url,
  }) = _ProductImageDto;

  factory ProductImageDto.fromJson(Map<String, dynamic> json) =>
      _$ProductImageDtoFromJson(json);
}

/// Paginated Product List Response
///
/// Represents paginated list of products from API.
@freezed
class PaginatedProductDto with _$PaginatedProductDto {
  const factory PaginatedProductDto({
    required List<ProductDto> data,
    required int total,
    int? limit,
    int? offset,
    int? totalPages,
    int? currentPage,
  }) = _PaginatedProductDto;

  factory PaginatedProductDto.fromJson(Map<String, dynamic> json) =>
      _$PaginatedProductDtoFromJson(json);
}
