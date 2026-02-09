import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tartibat/core/constants/app_colors.dart';
import 'package:tartibat/core/localization/app_localizations.dart';
import 'package:tartibat/core/utils/responsive.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_state.dart';
import 'package:tartibat/features/customer/widgets/checkout/address_bottom_sheet.dart';

class ProfileAddressesScreen extends StatelessWidget {
  const ProfileAddressesScreen({super.key});

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
          'saved_addresses'.tr(context),
          style: GoogleFonts.cairo(
            fontSize: r.fontSize(18),
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon:
                const Icon(Icons.add_circle_outline, color: AppColors.primary),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => BlocProvider.value(
                  value: context.read<CheckoutCubit>(),
                  child: const AddressBottomSheet(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CheckoutReady) {
            if (state.addresses.isEmpty) {
              return _buildEmptyState(context, r);
            }

            return ListView.builder(
              padding: EdgeInsets.all(r.spacing(16)),
              physics: const BouncingScrollPhysics(),
              itemCount: state.addresses.length,
              itemBuilder: (context, index) {
                final address = state.addresses[index];
                return Container(
                  margin: EdgeInsets.only(bottom: r.spacing(12)),
                  padding: EdgeInsets.all(r.spacing(16)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: address.isDefault
                          ? AppColors.primary
                          : Colors.grey.shade200,
                      width: address.isDefault ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              address.name,
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(16),
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          if (address.isDefault)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: r.spacing(10),
                                vertical: r.spacing(4),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'default'.tr(context),
                                style: GoogleFonts.cairo(
                                  fontSize: r.fontSize(11),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: r.spacing(8)),
                      Row(
                        children: [
                          Icon(Icons.phone,
                              size: 16, color: AppColors.textSecondary),
                          SizedBox(width: r.spacing(8)),
                          Text(
                            address.phone,
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(13),
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: r.spacing(6)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: AppColors.textSecondary),
                          SizedBox(width: r.spacing(8)),
                          Expanded(
                            child: Text(
                              address.fullAddress,
                              style: GoogleFonts.cairo(
                                fontSize: r.fontSize(13),
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
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
              Icons.location_off_outlined,
              size: r.responsive(mobile: 80, tablet: 100, desktop: 120),
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: r.spacing(24)),
          Text(
            'no_saved_addresses'.tr(context),
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
              'add_address_message'.tr(context),
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
