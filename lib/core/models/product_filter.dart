class ProductFilter {
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? sortBy;
  final bool? inStock;

  ProductFilter({
    this.category,
    this.minPrice,
    this.maxPrice,
    this.sortBy,
    this.inStock,
  });

  ProductFilter copyWith({
    String? category,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
    bool? inStock,
  }) {
    return ProductFilter(
      category: category ?? this.category,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      sortBy: sortBy ?? this.sortBy,
      inStock: inStock ?? this.inStock,
    );
  }

  bool get hasFilters =>
      category != null ||
      minPrice != null ||
      maxPrice != null ||
      sortBy != null ||
      inStock != null;

  void clear() {
    // Reset all filters
  }
}
