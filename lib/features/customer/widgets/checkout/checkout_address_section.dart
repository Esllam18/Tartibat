import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

import 'address_bottom_sheet.dart';

class CheckoutAddressSection extends StatelessWidget {
  const CheckoutAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(r.spacing(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'delivery_address'.tr(context),
                  style: GoogleFonts.cairo(
                    fontSize: r.fontSize(18),
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton.icon(
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
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: Text(
                    'add_new'.tr(context),
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(13),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: r.spacing(8),
                      vertical: r.spacing(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade200),
          BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutReady) {
                if (state.addresses.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(r.spacing(24)),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_off_outlined,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: r.spacing(12)),
                          Text(
                            'no_address_found'.tr(context),
                            style: GoogleFonts.cairo(
                              fontSize: r.fontSize(14),
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(r.spacing(16)),
                  itemCount: state.addresses.length,
                  separatorBuilder: (_, __) => SizedBox(height: r.spacing(12)),
                  itemBuilder: (context, index) {
                    final address = state.addresses[index];
                    final isSelected = state.selectedAddress?.id == address.id;

                    return GestureDetector(
                      onTap: () {
                        context.read<CheckoutCubit>().selectAddress(address);
                      },
                      child: Container(
                        padding: EdgeInsets.all(r.spacing(12)),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.08)
                              : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.grey.shade400,
                            ),
                            SizedBox(width: r.spacing(12)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        address.name,
                                        style: GoogleFonts.cairo(
                                          fontSize: r.fontSize(15),
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      if (address.isDefault) ...[
                                        SizedBox(width: r.spacing(8)),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: r.spacing(8),
                                            vertical: r.spacing(2),
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.success,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            'default'.tr(context),
                                            style: GoogleFonts.cairo(
                                              fontSize: r.fontSize(10),
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: r.spacing(4)),
                                  Text(
                                    address.phone,
                                    style: GoogleFonts.cairo(
                                      fontSize: r.fontSize(13),
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  SizedBox(height: r.spacing(4)),
                                  Text(
                                    address.fullAddress,
                                    style: GoogleFonts.cairo(
                                      fontSize: r.fontSize(12),
                                      color: AppColors.textSecondary,
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
