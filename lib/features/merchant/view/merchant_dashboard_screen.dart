import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../bloc/merchant_products_cubit.dart';
import '../bloc/merchant_products_state.dart';
import '../bloc/merchant_orders_cubit.dart';
import '../bloc/merchant_orders_state.dart';
import '../widgets/dashboard/stats_card.dart';
import '../widgets/dashboard/quick_actions.dart';
import '../widgets/dashboard/recent_orders_section.dart';

class MerchantDashboardScreen extends StatelessWidget {
  const MerchantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              context.read<MerchantProductsCubit>().loadProducts(),
              context.read<MerchantOrdersCubit>().loadOrders(),
            ]);
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(r.spacing(20)),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'merchant_dashboard'.tr(context),
                                style: GoogleFonts.cairo(
                                  fontSize: r.fontSize(28),
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: r.spacing(4)),
                              Text(
                                'manage_your_store'.tr(context),
                                style: GoogleFonts.cairo(
                                  fontSize: r.fontSize(14),
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(r.spacing(12)),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.store,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(r.spacing(16)),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatsSection(context, r),
                      SizedBox(height: r.spacing(20)),
                      const QuickActions(),
                      SizedBox(height: r.spacing(20)),
                      const RecentOrdersSection(),
                      SizedBox(height: r.spacing(80)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, Responsive r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'statistics'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(18),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: r.spacing(12)),
        BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
          builder: (context, productsState) {
            return BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
              builder: (context, ordersState) {
                final totalProducts = productsState is MerchantProductsLoaded
                    ? productsState.totalProducts
                    : 0;
                final activeProducts = productsState is MerchantProductsLoaded
                    ? productsState.activeProducts
                    : 0;
                final totalOrders = ordersState is MerchantOrdersLoaded
                    ? ordersState.totalOrders
                    : 0;
                final pendingOrders = ordersState is MerchantOrdersLoaded
                    ? ordersState.pendingOrders
                    : 0;
                final totalRevenue = ordersState is MerchantOrdersLoaded
                    ? ordersState.totalRevenue
                    : 0.0;

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatsCard(
                            title: 'products'.tr(context),
                            value: totalProducts.toString(),
                            subtitle: '$activeProducts ${'active'.tr(context)}',
                            icon: Icons.inventory_2,
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade600
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: r.spacing(12)),
                        Expanded(
                          child: StatsCard(
                            title: 'orders'.tr(context),
                            value: totalOrders.toString(),
                            subtitle: '$pendingOrders ${'pending'.tr(context)}',
                            icon: Icons.receipt_long,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange.shade400,
                                Colors.orange.shade600
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: r.spacing(12)),
                    StatsCard(
                      title: 'total_revenue'.tr(context),
                      value: '\$${totalRevenue.toStringAsFixed(2)}',
                      subtitle: 'all_time'.tr(context),
                      icon: Icons.attach_money,
                      gradient: AppColors.primaryGradient,
                      isWide: true,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
