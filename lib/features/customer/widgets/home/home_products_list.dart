import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/features/customer/view/product_details_screen.dart';

class HomeProductsList extends StatelessWidget {
  final String category;

  const HomeProductsList({super.key, required this.category});

  static final List<Map<String, dynamic>> _products = [
    {
      'name': 'كنبة مودرن فاخرة',
      'location': 'صنع في إيطاليا',
      'price': 4500,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=500',
    },
    {
      'name': 'طاولة طعام خشبية',
      'location': 'خشب زان طبيعي',
      'price': 3200,
      'image':
          'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=500',
    },
    {
      'name': 'كرسي مكتب جلد',
      'location': 'جلد طبيعي',
      'price': 1200,
      'image':
          'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=500',
    },
    {
      'name': 'سرير كينج فخم',
      'location': 'مع مرتبة طبية',
      'price': 6500,
      'image':
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
    },
    {
      'name': 'خزانة كتب عصرية',
      'location': 'خشب MDF مقاوم',
      'price': 2100,
      'image':
          'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
          child: ProductListItem(product: _products[index]),
        ),
        childCount: _products.length,
      ),
    );
  }
}

class ProductListItem extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductListItem({super.key, required this.product});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: widget.product),
        ),
      ),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(18),
              ),
              child: Image.network(
                widget.product['image'] as String,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 130,
                  color: const Color(0xFFF5F6FA),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product['name'] as String,
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.product['location'] as String,
                                      style: GoogleFonts.cairo(
                                        fontSize: 14,
                                        color: const Color(0x99000000),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : AppColors.primary,
                            size: 22,
                          ),
                          onPressed: () =>
                              setState(() => isFavorite = !isFavorite),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${widget.product['price']} جنيه',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
