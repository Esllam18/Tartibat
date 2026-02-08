import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/localization/app_localizations.dart';

class FavoritesHeader extends StatelessWidget {
  const FavoritesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Container(
      padding: EdgeInsets.all(r.spacing(20)),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'favorites'.tr(context),
                style: GoogleFonts.cairo(
                  fontSize: r.fontSize(26),
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: r.spacing(4)),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final count = state is FavoritesLoaded ? state.count : 0;
                  return Text(
                    '$count ${'items'.tr(context)}',
                    style: GoogleFonts.cairo(
                      fontSize: r.fontSize(14),
                      color: AppColors.textSecondary,
                    ),
                  );
                },
              ),
            ],
          ),
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is! FavoritesLoaded || state.isEmpty) {
                return const SizedBox();
              }

              return IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => _showClearDialog(context),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('clear_favorites'.tr(context)),
        content: Text('clear_favorites_confirm'.tr(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr(context)),
          ),
          TextButton(
            onPressed: () {
              context.read<FavoritesCubit>().clearAll();
              Navigator.pop(context);
            },
            child: Text(
              'clear'.tr(context),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
