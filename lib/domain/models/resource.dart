class Resource {
  final String id;
  final String name;
  final String description;
  final String url;
  final String imageUrl;

  Resource({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.imageUrl,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'url': url,
      'imageUrl': imageUrl,
    };
  }
}
