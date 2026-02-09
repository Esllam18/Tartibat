class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.imageUrl,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'imageUrl': imageUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        imageUrl: json['imageUrl'],
      );

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? imageUrl,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
