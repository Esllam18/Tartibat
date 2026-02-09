class MerchantStats {
  final int totalProducts;
  final int activeProducts;
  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final double totalRevenue;
  final double monthlyRevenue;

  MerchantStats({
    required this.totalProducts,
    required this.activeProducts,
    required this.totalOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.totalRevenue,
    required this.monthlyRevenue,
  });

  Map<String, dynamic> toJson() => {
        'totalProducts': totalProducts,
        'activeProducts': activeProducts,
        'totalOrders': totalOrders,
        'pendingOrders': pendingOrders,
        'completedOrders': completedOrders,
        'totalRevenue': totalRevenue,
        'monthlyRevenue': monthlyRevenue,
      };

  factory MerchantStats.fromJson(Map<String, dynamic> json) => MerchantStats(
        totalProducts: json['totalProducts'] ?? 0,
        activeProducts: json['activeProducts'] ?? 0,
        totalOrders: json['totalOrders'] ?? 0,
        pendingOrders: json['pendingOrders'] ?? 0,
        completedOrders: json['completedOrders'] ?? 0,
        totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
        monthlyRevenue: (json['monthlyRevenue'] ?? 0).toDouble(),
      );
}
