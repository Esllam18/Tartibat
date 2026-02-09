import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import '../bloc/merchant_products_cubit.dart';
import '../bloc/merchant_products_state.dart';
import '../widgets/products/merchant_product_card.dart';
import 'add_product_screen.dart';

class MerchantProductsScreen extends StatelessWidget {
  const MerchantProductsScreen({super.key});

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'my_products'.tr(context),
                        style: GoogleFonts.cairo(
                          fontSize: r.fontSize(24),
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
                        builder: (context, state) {
                          final count = state is MerchantProductsLoaded
                              ? state.totalProducts
                              : 0;
                          return Text(
                            '$count ${'products'.tr(context)}',
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(13),
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  FloatingActionButton(
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
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<MerchantProductsCubit, MerchantProductsState>(
                builder: (context, state) {
                  if (state is MerchantProductsLoading) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  if (state is MerchantProductsLoaded) {
                    if (state.products.isEmpty) {
                      return _buildEmptyState(context, r);
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<MerchantProductsCubit>().loadProducts(),
                      child: ListView.builder(
                        padding: EdgeInsets.all(r.spacing(16)),
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return MerchantProductCard(
                            product: state.products[index],
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
              Icons.inventory_2_outlined,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_products_yet'.tr(context),
            style: GoogleFonts.cairo(
              fontSize: r.fontSize(18),
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: r.spacing(12)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: r.spacing(40)),
            child: Text(
              'add_your_first_product'.tr(context),
              style: GoogleFonts.cairo(
                fontSize: r.fontSize(14),
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
