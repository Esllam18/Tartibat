import 'package:flutter/material.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_add_to_cart_bar.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_description_card.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_details_app_bar.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_details_header.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_price_card.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_quantity_selector.dart';
import 'package:tartibat/features/customer/widgets/home/product_details/product_specifications_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../data/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final Product? productModel;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.productModel,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ProductDetailsAppBar(
            imageUrl: widget.product['image'] as String,
            productId: widget.product['id'] as String? ?? '',
            productModel: widget.productModel,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(r.paddingHorizontal),
              child: Column(
                children: [
                  ProductDetailsHeader(product: widget.product),
                  SizedBox(height: r.spacing(20)),
                  ProductPriceCard(price: widget.product['price']),
                  SizedBox(height: r.spacing(20)),
                  ProductQuantitySelector(
                    quantity: _quantity,
                    onQuantityChanged: (q) => setState(() => _quantity = q),
                  ),
                  SizedBox(height: r.spacing(20)),
                  const ProductDescriptionCard(),
                  SizedBox(height: r.spacing(20)),
                  const ProductSpecificationsCard(),
                  SizedBox(height: r.spacing(100)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ProductAddToCartBar(
        quantity: _quantity,
        price: widget.product['price'],
        productModel: widget.productModel, // ✅ MUST PASS THIS
      ),
    );
  }
}
