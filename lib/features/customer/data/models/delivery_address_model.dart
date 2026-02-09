class DeliveryAddress {
  final String id;
  final String name;
  final String phone;
  final String street;
  final String city;
  final String area;
  final String building;
  final String? apartment;
  final bool isDefault;

  DeliveryAddress({
    required this.id,
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.area,
    required this.building,
    this.apartment,
    this.isDefault = false,
  });

  String get fullAddress {
    final apt = apartment != null ? ', $apartment' : '';
    return '$building, $street$apt, $area, $city';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'street': street,
        'city': city,
        'area': area,
        'building': building,
        'apartment': apartment,
        'isDefault': isDefault,
      };

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        street: json['street'] ?? '',
        city: json['city'] ?? '',
        area: json['area'] ?? '',
        building: json['building'] ?? '',
        apartment: json['apartment'],
        isDefault: json['isDefault'] ?? false,
      );
}
