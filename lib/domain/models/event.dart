class Event {
  final String id;
  final String title;
  final String? subtitle;
  final DateTime? startDate;
  final String? location;
  final String? imageUrl;

  Event({
    required this.id,
    required this.title,
    this.subtitle,
    this.startDate,
    this.location,
    this.imageUrl,
  });
}
