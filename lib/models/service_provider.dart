class ServiceProvider {
  final String id;
  final String name;
  final String category;
  final String skill;
  final double rating;
  final int price;
  final String description;
  final String avatarUrl;
  final bool isTopRated;
  final List<String> tags;

  ServiceProvider({
    required this.id,
    required this.name,
    required this.category,
    required this.skill,
    required this.rating,
    required this.price,
    required this.description,
    required this.avatarUrl,
    this.isTopRated = false,
    this.tags = const [],
  });
}