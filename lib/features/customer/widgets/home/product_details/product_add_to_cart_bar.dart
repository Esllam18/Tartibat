import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import 'package:tartibat/core/utils/responsive.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/cart_state.dart';
import 'package:tartibat/features/customer/data/models/product_model.dart';

class ProductAddToCartBar extends StatelessWidget {
  final int quantity;
  final dynamic price;
  final Product? productModel;

  const ProductAddToCartBar({
    super.key,
    required this.quantity,
    required this.price,
    this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final total = (price * quantity).toStringAsFixed(0);

    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) =>
          (previous is! CartItemAdded && current is CartItemAdded) ||
          (previous is! CartItemRemoved && current is CartItemRemoved),
      listener: (context, state) {
        if (state is CartItemAdded) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: Text(
                      'added_to_cart'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        } else if (state is CartItemRemoved) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.white, size: 20),
                  SizedBox(width: r.spacing(12)),
                  Expanded(
                    child: Text(
                      'removed_from_cart'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(r.spacing(16)),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final isInCart = state is CartLoaded && productModel != null
                  ? state.isInCart(productModel!.id)
                  : false;

              return Row(
                children: [
                  if (!isInCart) ...[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'total'.tr(context),
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(13),
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$$total',
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(24),
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: r.spacing(16)),
                  ],
                  Expanded(
                    child: SizedBox(
                      height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                      child: ElevatedButton(
                        onPressed: productModel != null
                            ? () {
                                if (isInCart) {
                                  context
                                      .read<CartCubit>()
                                      .removeItem(productModel!.id);
                                } else {
                                  context.read<CartCubit>().addToCart(
                                        productModel!,
                                        quantity,
                                      );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isInCart ? AppColors.error : AppColors.primary,
                          disabledBackgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isInCart
                                  ? Icons.remove_shopping_cart_outlined
                                  : Icons.shopping_cart_outlined,
                              size: r.responsive(
                                mobile: 22,
                                tablet: 24,
                                desktop: 26,
                              ),
                            ),
                            SizedBox(width: r.spacing(10)),
                            Text(
                              isInCart
                                  ? 'remove_from_cart'.tr(context)
                                  : 'add_to_cart'.tr(context),
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(16),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
