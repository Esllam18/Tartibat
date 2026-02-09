import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/features/customer/data/bloc/orders_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/orders_state.dart';
import 'package:tartibat/features/customer/widgets/orders/order_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';

import '../data/services/orders_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrdersService>(
      future: OrdersService.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return BlocProvider(
          create: (_) => OrdersCubit(snapshot.data!)..loadOrders(),
          child: const _OrdersScreenContent(),
        );
      },
    );
  }
}

class _OrdersScreenContent extends StatelessWidget {
  const _OrdersScreenContent();

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(r.spacing(8)),
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back,
                color: AppColors.textPrimary, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'my_orders'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(18),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            onPressed: () => context.read<OrdersCubit>().refresh(),
          ),
        ],
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrdersEmpty) {
            return _buildEmptyState(context, r);
          }

          if (state is OrdersError) {
            return _buildErrorState(context, r, state.message);
          }

          if (state is OrdersLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<OrdersCubit>().refresh(),
              child: ListView.builder(
                padding: EdgeInsets.all(r.spacing(16)),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: state.orders[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
            color: Colors.grey.shade300,
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_orders_yet'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            'start_shopping_now'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: r.spacing(32)),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(32),
                vertical: r.spacing(16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'browse_products'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(14),
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Responsive r, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
            color: AppColors.error,
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'error_loading_orders'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            message,
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: r.spacing(32)),
          ElevatedButton(
            onPressed: () => context.read<OrdersCubit>().refresh(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: r.spacing(32),
                vertical: r.spacing(16),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'try_again'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(14),
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
