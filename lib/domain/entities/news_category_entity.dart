/// Represents a news category fetched from the API.
///
/// Used to populate the dynamic TabBar in the News screen.
class NewsCategoryEntity {
  final String id;
  final String name;

  const NewsCategoryEntity({
    required this.id,
    required this.name,
  });

  factory NewsCategoryEntity.empty() => const NewsCategoryEntity(
        id: '',
        name: '',
      );
}
