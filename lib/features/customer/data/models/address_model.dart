class Address {
  final String id;
  final String name;
  final String phone;
  final String street;
  final String building;
  final String? floor;
  final String? apartment;
  final String city;
  final String area;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.phone,
    required this.street,
    required this.building,
    this.floor,
    this.apartment,
    required this.city,
    required this.area,
    this.isDefault = false,
  });

  String get fullAddress {
    final parts = [
      street,
      'Building $building',
      if (floor != null && floor!.isNotEmpty) 'Floor $floor',
      if (apartment != null && apartment!.isNotEmpty) 'Apt $apartment',
      area,
      city,
    ];
    return parts.join(', ');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'street': street,
        'building': building,
        'floor': floor,
        'apartment': apartment,
        'city': city,
        'area': area,
        'isDefault': isDefault,
      };

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        street: json['street'] ?? '',
        building: json['building'] ?? '',
        floor: json['floor'],
        apartment: json['apartment'],
        city: json['city'] ?? '',
        area: json['area'] ?? '',
        isDefault: json['isDefault'] ?? false,
      );

  Address copyWith({
    String? id,
    String? name,
    String? phone,
    String? street,
    String? building,
    String? floor,
    String? apartment,
    String? city,
    String? area,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      building: building ?? this.building,
      floor: floor ?? this.floor,
      apartment: apartment ?? this.apartment,
      city: city ?? this.city,
      area: area ?? this.area,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
