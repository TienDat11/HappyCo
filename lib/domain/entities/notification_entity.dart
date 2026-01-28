class NotificationEntity {
  final String id;
  final String title;
  final String description;
  final String? iconName;
  final bool isRead;
  final DateTime createdAt;
  final String imageUrl;

  const NotificationEntity({
    this.iconName,
    this.isRead = false,
    required this.title,
    required this.description,
    required this.id,
    required this.createdAt,
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NotificationEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
