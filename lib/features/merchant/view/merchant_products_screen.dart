import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/services/merchant_products_service.dart';
import '../bloc/merchant_products_cubit.dart';
import '../bloc/merchant_products_state.dart';
import './add_product_screen.dart';
import '../widgets/products/merchant_product_card.dart';

class MerchantProductsScreen extends StatelessWidget {
  const MerchantProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MerchantProductsService>(
      future: MerchantProductsService.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return BlocProvider(
          create: (_) => MerchantProductsCubit(snapshot.data!),
          child: const _MerchantProductsScreenContent(),
        );
      },
    );
  }
}

class _MerchantProductsScreenContent extends StatelessWidget {
  const _MerchantProductsScreenContent();

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'my_products'.tr(context),
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
            onPressed: () {
              context.read<MerchantProductsCubit>().refresh();
            },
          ),
        ],
      ),
      body: BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
        builder: (context, state) {
          print('📊 Current State: ${state.runtimeType}');

          if (state is MerchantProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MerchantProductsError) {
            return _buildErrorState(context, r, state.message);
          }

          if (state is MerchantProductsLoaded) {
            if (state.products.isEmpty) {
              return _buildEmptyState(context, r);
            }

            return RefreshIndicator(
              onRefresh: () => context.read<MerchantProductsCubit>().refresh(),
              child: Column(
                children: [
                  // Stats Card
                  Container(
                    margin: EdgeInsets.all(r.spacing(16)),
                    padding: EdgeInsets.all(r.spacing(16)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          context,
                          r,
                          'total_products'.tr(context),
                          state.totalProducts.toString(),
                          Icons.inventory_2,
                          AppColors.primary,
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.shade300,
                        ),
                        _buildStatItem(
                          context,
                          r,
                          'active_products'.tr(context),
                          state.activeProducts.toString(),
                          Icons.check_circle,
                          AppColors.success,
                        ),
                      ],
                    ),
                  ),

                  // Products List
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: r.spacing(16)),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return MerchantProductCard(
                          product: state.products[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<MerchantProductsCubit>(),
                child: const AddProductScreen(),
              ),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'add_product'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(14),
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    Responsive r,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: r.spacing(8)),
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(24),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(12),
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, Responsive r) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
            color: Colors.grey.shade300,
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_products_yet'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(8)),
          Text(
            'add_your_first_product'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(14),
              color: AppColors.textSecondary,
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
            'error_loading_products'.tr(context),
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
            onPressed: () => context.read<MerchantProductsCubit>().refresh(),
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
