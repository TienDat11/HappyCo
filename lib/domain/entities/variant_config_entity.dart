/// Variant Config Entity
///
/// Represents a dynamic attribute configuration for product variants.
/// The API provides these configs to define what selectors to show
/// (e.g. "Màu Sắc", "Phân Loại", "Thương Hiệu").
class VariantConfigEntity {
  final String key;
  final String label;

  const VariantConfigEntity({
    required this.key,
    required this.label,
  });

  factory VariantConfigEntity.empty() => const VariantConfigEntity(
        key: '',
        label: '',
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VariantConfigEntity && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
