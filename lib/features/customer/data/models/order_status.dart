enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  outForDelivery,
  delivered,
  cancelled;

  String getDisplayName(bool isArabic) {
    switch (this) {
      case OrderStatus.pending:
        return isArabic ? 'قيد الانتظار' : 'Pending';
      case OrderStatus.confirmed:
        return isArabic ? 'تم التأكيد' : 'Confirmed';
      case OrderStatus.processing:
        return isArabic ? 'قيد التحضير' : 'Processing';
      case OrderStatus.shipped:
        return isArabic ? 'تم الشحن' : 'Shipped';
      case OrderStatus.outForDelivery:
        return isArabic ? 'في الطريق' : 'Out for Delivery';
      case OrderStatus.delivered:
        return isArabic ? 'تم التوصيل' : 'Delivered';
      case OrderStatus.cancelled:
        return isArabic ? 'ملغي' : 'Cancelled';
    }
  }
}
