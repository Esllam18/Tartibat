import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../bloc/merchant_orders_cubit.dart';
import '../../bloc/merchant_orders_state.dart';
import '../orders/merchant_order_card.dart';
import '../../view/merchant_orders_screen.dart';

class RecentOrdersSection extends StatelessWidget {
  const RecentOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'recent_orders'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(18),
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const MerchantOrdersScreen()),
                );
              },
              child: Text(
                'view_all'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(13),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: r.spacing(12)),
        BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
          builder: (context, state) {
            if (state is MerchantOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MerchantOrdersLoaded) {
              if (state.orders.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(r.spacing(32)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: r.spacing(12)),
                        Text(
                          'no_orders_yet'.tr(context),
                          style: GoogleFonts.cairo(
                            fontSize: r.fontSize(14),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final recentOrders = state.orders.take(3).toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentOrders.length,
                itemBuilder: (context, index) {
                  return MerchantOrderCard(order: recentOrders[index]);
                },
              );
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
