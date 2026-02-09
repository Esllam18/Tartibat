class MerchantProfile {
  final String id;
  final String storeName;
  final String storeNameAr;
  final String ownerName;
  final String email;
  final String phone;
  final String? imageUrl;
  final double totalEarnings;
  final int totalProductsSold;
  final int totalOrdersHandled;
  final DateTime joinedDate;

  MerchantProfile({
    required this.id,
    required this.storeName,
    required this.storeNameAr,
    required this.ownerName,
    required this.email,
    required this.phone,
    this.imageUrl,
    this.totalEarnings = 0.0,
    this.totalProductsSold = 0,
    this.totalOrdersHandled = 0,
    DateTime? joinedDate,
  }) : joinedDate = joinedDate ?? DateTime.now();

  String get initials {
    final parts = ownerName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return ownerName.isNotEmpty ? ownerName[0].toUpperCase() : 'M';
  }

  String getStoreName(bool isArabic) => isArabic ? storeNameAr : storeName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeName': storeName,
        'storeNameAr': storeNameAr,
        'ownerName': ownerName,
        'email': email,
        'phone': phone,
        'imageUrl': imageUrl,
        'totalEarnings': totalEarnings,
        'totalProductsSold': totalProductsSold,
        'totalOrdersHandled': totalOrdersHandled,
        'joinedDate': joinedDate.toIso8601String(),
      };

  factory MerchantProfile.fromJson(Map<String, dynamic> json) =>
      MerchantProfile(
        id: json['id'] ?? '',
        storeName: json['storeName'] ?? '',
        storeNameAr: json['storeNameAr'] ?? '',
        ownerName: json['ownerName'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        imageUrl: json['imageUrl'],
        totalEarnings: (json['totalEarnings'] ?? 0).toDouble(),
        totalProductsSold: json['totalProductsSold'] ?? 0,
        totalOrdersHandled: json['totalOrdersHandled'] ?? 0,
        joinedDate: json['joinedDate'] != null
            ? DateTime.parse(json['joinedDate'])
            : DateTime.now(),
      );

  MerchantProfile copyWith({
    String? storeName,
    String? storeNameAr,
    String? ownerName,
    String? email,
    String? phone,
    String? imageUrl,
    double? totalEarnings,
    int? totalProductsSold,
    int? totalOrdersHandled,
  }) {
    return MerchantProfile(
      id: id,
      storeName: storeName ?? this.storeName,
      storeNameAr: storeNameAr ?? this.storeNameAr,
      ownerName: ownerName ?? this.ownerName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      totalProductsSold: totalProductsSold ?? this.totalProductsSold,
      totalOrdersHandled: totalOrdersHandled ?? this.totalOrdersHandled,
      joinedDate: joinedDate,
    );
  }
}
