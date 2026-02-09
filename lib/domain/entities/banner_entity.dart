/// Banner Entity
///
/// Domain layer entity representing a marketing banner.
class BannerEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String? actionUrl;

  const BannerEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.actionUrl,
  });

  factory BannerEntity.empty() => const BannerEntity(
        id: '',
        title: '',
        imageUrl: '',
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BannerEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
