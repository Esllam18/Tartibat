import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/cart_state.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class CheckoutTotalBar extends StatelessWidget {
  const CheckoutTotalBar({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        if (cartState is! CartLoaded) return const SizedBox();

        return Container(
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
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'total'.tr(context),
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${cartState.total.toStringAsFixed(2)}',
                      style: GoogleFonts.cairo(
                        fontSize: r.fontSize(24),
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: r.spacing(16)),
                Expanded(
                  child: BlocBuilder<CheckoutCubit, CheckoutState>(
                    builder: (context, checkoutState) {
                      final canPlaceOrder = checkoutState is CheckoutReady &&
                          checkoutState.canPlaceOrder;

                      return SizedBox(
                        height:
                            r.responsive(mobile: 56, tablet: 60, desktop: 64),
                        child: ElevatedButton(
                          onPressed: canPlaceOrder
                              ? () {
                                  context.read<CheckoutCubit>().placeOrder(
                                        cartState.items,
                                        cartState.total,
                                      );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'place_order'.tr(context),
                                style: GoogleFonts.cairo(
                                  fontSize: r.fontSize(16),
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: r.spacing(8)),
                              const Icon(Icons.check_circle_outline, size: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
