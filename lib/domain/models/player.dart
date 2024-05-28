class Player {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? email;

  Player({
    required this.id,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.email,
  });
}
