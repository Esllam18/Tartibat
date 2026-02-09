import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../bloc/merchant_orders_cubit.dart';
import '../bloc/merchant_orders_state.dart';
import '../widgets/orders/merchant_order_card.dart';

class MerchantOrdersScreen extends StatefulWidget {
  const MerchantOrdersScreen({super.key});

  @override
  State<MerchantOrdersScreen> createState() => _MerchantOrdersScreenState();
}

class _MerchantOrdersScreenState extends State<MerchantOrdersScreen> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(r.spacing(20)),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'orders_management'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(24),
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: r.spacing(12)),
                  _buildFilterChips(r),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<MerchantOrdersCubit, MerchantOrdersState>(
                builder: (context, state) {
                  if (state is MerchantOrdersLoading) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  if (state is MerchantOrdersLoaded) {
                    final filteredOrders = _getFilteredOrders(state);

                    if (filteredOrders.isEmpty) {
                      return _buildEmptyState(context, r);
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<MerchantOrdersCubit>().loadOrders(),
                      child: ListView.builder(
                        padding: EdgeInsets.all(r.spacing(16)),
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          return MerchantOrderCard(
                            order: filteredOrders[index],
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(Responsive r) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip('all', 'all'.tr(context), r),
          SizedBox(width: r.spacing(8)),
          _buildChip('pending', 'pending'.tr(context), r),
          SizedBox(width: r.spacing(8)),
          _buildChip('processing', 'processing'.tr(context), r),
          SizedBox(width: r.spacing(8)),
          _buildChip('shipped', 'shipped'.tr(context), r),
          SizedBox(width: r.spacing(8)),
          _buildChip('delivered', 'delivered'.tr(context), r),
        ],
      ),
    );
  }

  Widget _buildChip(String value, String label, Responsive r) {
    final isSelected = _selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = value),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: r.spacing(16),
          vertical: r.spacing(8),
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(13),
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  List<dynamic> _getFilteredOrders(MerchantOrdersLoaded state) {
    if (_selectedFilter == 'all') return state.orders;
    return state.orders
        .where((order) => order.status == _selectedFilter)
        .toList();
  }

  Widget _buildEmptyState(BuildContext context, Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(r.spacing(30)),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_orders_found'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(12)),
          Text(
            'no_orders_in_category'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
