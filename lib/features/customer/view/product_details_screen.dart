import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isFavorite = false;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context, r),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(r.paddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, r),
                  SizedBox(height: r.spacing(20)),
                  _buildPriceSection(context, r),
                  SizedBox(height: r.spacing(24)),
                  _buildQuantitySelector(context, r),
                  SizedBox(height: r.spacing(24)),
                  _buildDescription(context, r),
                  SizedBox(height: r.spacing(24)),
                  _buildSpecifications(context, r),
                  SizedBox(height: r.spacing(100)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context, r),
    );
  }

  Widget _buildAppBar(BuildContext context, Responsive r) {
    return SliverAppBar(
      expandedHeight: r.responsive(mobile: 300, tablet: 350, desktop: 400),
      pinned: true,
      backgroundColor: AppColors.surface,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(r.spacing(8)),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: AppColors.shadowMedium, blurRadius: 10)
            ],
          ),
          child: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.textPrimary, size: 18),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.shadowMedium, blurRadius: 10)
              ],
            ),
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? AppColors.error : AppColors.textPrimary,
              size: 20,
            ),
          ),
          onPressed: () => setState(() => _isFavorite = !_isFavorite),
        ),
        IconButton(
          icon: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: AppColors.shadowMedium, blurRadius: 10)
              ],
            ),
            child: const Icon(Icons.share_outlined,
                color: AppColors.textPrimary, size: 20),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('share_product'.tr(context)),
                backgroundColor: AppColors.primary,
              ),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          widget.product['image'] as String,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.background,
            child: Icon(
              Icons.image_not_supported,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primaryLight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.product['name'] as String,
            style: AppTextStyles.h2(context)),
        SizedBox(height: r.spacing(8)),
        Row(
          children: [
            Icon(Icons.verified,
                size: r.responsive(mobile: 18, tablet: 20, desktop: 22),
                color: AppColors.success),
            SizedBox(width: r.spacing(8)),
            Expanded(
              child: Text(
                widget.product['location'] as String,
                style: AppTextStyles.bodyMedium(context)
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceSection(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('price'.tr(context),
                  style: AppTextStyles.bodySmall(context)
                      .copyWith(color: Colors.white70)),
              SizedBox(height: r.spacing(4)),
              Text(
                '${widget.product['price']} ${'egp'.tr(context)}',
                style: AppTextStyles.h2(context)
                    .copyWith(color: Colors.white, fontSize: r.fontSize(28)),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(r.spacing(12)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Icon(Icons.local_offer,
                color: Colors.white,
                size: r.responsive(mobile: 28, tablet: 32, desktop: 36)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: Offset(0, 4))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('quantity'.tr(context), style: AppTextStyles.h4(context)),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: AppColors.primary),
                  iconSize: r.responsive(mobile: 28, tablet: 32, desktop: 36),
                  onPressed: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
                  child: Text(
                    '$_quantity',
                    style: AppTextStyles.h3(context)
                        .copyWith(fontSize: r.fontSize(20)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline,
                      color: AppColors.primary),
                  iconSize: r.responsive(mobile: 28, tablet: 32, desktop: 36),
                  onPressed: () => setState(() => _quantity++),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(r.spacing(8)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Icon(Icons.description_outlined,
                    color: AppColors.primary,
                    size: r.responsive(mobile: 22, tablet: 24, desktop: 26)),
              ),
              SizedBox(width: r.spacing(12)),
              Text('description'.tr(context), style: AppTextStyles.h4(context)),
            ],
          ),
          SizedBox(height: r.spacing(16)),
          Text(
            'هذا المنتج مصنوع من مواد عالية الجودة ويتميز بتصميم عصري وأنيق يناسب جميع الأذواق. يوفر راحة استثنائية ومتانة طويلة الأمد.',
            style: AppTextStyles.bodyMedium(context).copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifications(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 15,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(r.spacing(8)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Icon(Icons.info_outline,
                    color: AppColors.primary,
                    size: r.responsive(mobile: 22, tablet: 24, desktop: 26)),
              ),
              SizedBox(width: r.spacing(12)),
              Text('specifications'.tr(context),
                  style: AppTextStyles.h4(context)),
            ],
          ),
          SizedBox(height: r.spacing(16)),
          _buildSpecRow(context, r, 'material'.tr(context), 'خشب طبيعي'),
          Divider(height: r.spacing(24)),
          _buildSpecRow(context, r, 'dimensions'.tr(context), '200 × 150 سم'),
          Divider(height: r.spacing(24)),
          _buildSpecRow(context, r, 'weight'.tr(context), '45 كجم'),
          Divider(height: r.spacing(24)),
          _buildSpecRow(context, r, 'warranty'.tr(context), 'سنتان'),
        ],
      ),
    );
  }

  Widget _buildSpecRow(
      BuildContext context, Responsive r, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium(context)),
        Text(value,
            style: AppTextStyles.bodyMedium(context)
                .copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.spacing(AppDimensions.paddingMedium)),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: r.spacing(12)),
                            Expanded(
                              child: Text('added_to_cart'.tr(context)),
                            ),
                          ],
                        ),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusLarge),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: r.responsive(
                              mobile: 22, tablet: 24, desktop: 26)),
                      SizedBox(width: r.spacing(12)),
                      Text('add_to_cart'.tr(context),
                          style: AppTextStyles.buttonStatic),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
