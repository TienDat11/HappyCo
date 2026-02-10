import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_dto.freezed.dart';
part 'product_detail_dto.g.dart';

/// Defensive JSON converters for API type inconsistencies
/// The API sometimes returns different types for the same field depending on context

/// Safely converts any value to String?
String? _flexibleString(dynamic value) {
  if (value == null) return null;
  if (value is String) return value;
  return value.toString();
}

/// Safely converts any value to Map<String, dynamic>?
Map<String, dynamic>? _flexibleMap(dynamic value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  return null;
}

/// Flexible converter for unit_conversion field
/// API returns:
/// - Object { _id, name, values[] } in top-level productColors
/// - String in product_relates' productColors
/// We return the object if valid Map, otherwise null (ignore string case)
Map<String, dynamic>? _flexibleUnitConversion(dynamic value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  // String or other type → ignore (not applicable for our use case)
  return null;
}

/// Product Detail Data Transfer Object
///
/// Full product detail from GET /products/{id}.
/// Differs from [ProductDto] (list-level):
/// - [category] is expanded to object { _id, name }
/// - [productRelates] are fully populated ProductDetailDto objects
/// - [productColors] has full variant data with [value] map
/// - [description] is present (HTML, excluded from entity due to base64 bloat)
@freezed
class ProductDetailDto with _$ProductDetailDto {
  const factory ProductDetailDto({
    @JsonKey(name: '_id') required String id,
    required String name,
    String? description,
    @JsonKey(name: 'category') CategoryRefDto? categoryRef,
    int? quantity,
    @JsonKey(name: 'sold_quantity') int? soldQuantity,
    String? code,
    String? barcode,
    String? unit,
    @JsonKey(name: 'productColors') List<ProductColorVariantDto>? productColors,
    @JsonKey(name: 'configProductColors')
    List<ConfigProductColorDto>? configProductColors,
    String? status,
    @JsonKey(name: 'link_video') String? linkVideo,
    bool? hot,
    @JsonKey(name: 'is_wholesale_price') bool? isWholesalePrice,
    @JsonKey(name: 'product_relates') List<ProductRelateDto>? productRelates,
    @JsonKey(name: 'listImage') List<ProductDetailImageDto>? listImage,
    @JsonKey(name: 'statusWarehouse') String? statusWarehouse,
  }) = _ProductDetailDto;

  factory ProductDetailDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDtoFromJson(json);
}

/// Category reference in detail response (expanded from string ID)
@freezed
class CategoryRefDto with _$CategoryRefDto {
  const factory CategoryRefDto({
    @JsonKey(name: '_id') required String id,
    required String name,
  }) = _CategoryRefDto;

  factory CategoryRefDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryRefDtoFromJson(json);
}

/// Extended product color variant with dynamic [value] map
@freezed
class ProductColorVariantDto with _$ProductColorVariantDto {
  const factory ProductColorVariantDto({
    @JsonKey(name: '_id') required String id,
    required int price,
    @JsonKey(name: 'price_listed') int? priceListed,
    @JsonKey(name: 'price_selling') int? priceSelling,
    int? quantity,
    @JsonKey(fromJson: _flexibleString) String? image,
    @JsonKey(name: 'SKU') String? sku,
    bool? status,
    @JsonKey(fromJson: _flexibleString) String? barcode,
    @JsonKey(name: 'value', fromJson: _flexibleMap) Map<String, dynamic>? value,
    @JsonKey(name: 'unit_conversion', fromJson: _flexibleUnitConversion)
    Map<String, dynamic>? unitConversion,
  }) = _ProductColorVariantDto;

  factory ProductColorVariantDto.fromJson(Map<String, dynamic> json) =>
      _$ProductColorVariantDtoFromJson(json);
}

/// Dynamic attribute configuration for variant selectors
@freezed
class ConfigProductColorDto with _$ConfigProductColorDto {
  const factory ConfigProductColorDto({
    @JsonKey(name: '_id') required String id,
    required String key,
    required String label,
    String? type,
    bool? enabled,
  }) = _ConfigProductColorDto;

  factory ConfigProductColorDto.fromJson(Map<String, dynamic> json) =>
      _$ConfigProductColorDtoFromJson(json);
}

/// Image in detail response
@freezed
class ProductDetailImageDto with _$ProductDetailImageDto {
  const factory ProductDetailImageDto({
    @JsonKey(name: '_id') required String id,
    String? name,
    required String url,
    String? mimetype,
    int? size,
  }) = _ProductDetailImageDto;

  factory ProductDetailImageDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailImageDtoFromJson(json);
}

/// Related product in detail response (fully populated)
@freezed
class ProductRelateDto with _$ProductRelateDto {
  const factory ProductRelateDto({
    @JsonKey(name: '_id') required String id,
    required String name,
    @JsonKey(name: 'category') CategoryRefDto? categoryRef,
    int? quantity,
    @JsonKey(name: 'sold_quantity') int? soldQuantity,
    String? unit,
    @JsonKey(name: 'productColors') List<ProductColorVariantDto>? productColors,
    @JsonKey(name: 'listImage') List<ProductDetailImageDto>? listImage,
    String? status,
    bool? hot,
    @JsonKey(name: 'statusWarehouse') String? statusWarehouse,
  }) = _ProductRelateDto;

  factory ProductRelateDto.fromJson(Map<String, dynamic> json) =>
      _$ProductRelateDtoFromJson(json);
}
