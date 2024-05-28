class Mentor {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? bio;
  final String? title;
  final String? company;
  final String? location;
  final String? linkedin;
  final String? twitter;
  final String? github;
  final String? website;
  final String? skills;
  final String? availability;
  final String? createdAt;
  final String? updatedAt;

  Mentor({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.bio,
    this.title,
    this.company,
    this.location,
    this.linkedin,
    this.twitter,
    this.github,
    this.website,
    this.skills,
    this.availability,
    this.createdAt,
    this.updatedAt,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      imageUrl: json['imageUrl'],
      bio: json['bio'],
      title: json['title'],
      company: json['company'],
      location: json['location'],
      linkedin: json['linkedin'],
      twitter: json['twitter'],
      github: json['github'],
      website: json['website'],
      skills: json['skills'],
      availability: json['availability'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': imageUrl,
      'bio': bio,
      'title': title,
      'company': company,
      'location': location,
      'linkedin': linkedin,
      'twitter': twitter,
      'github': github,
      'website': website,
      'skills': skills,
      'availability': availability,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
