import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/favorites_state.dart';
import 'package:tartibat/features/customer/widgets/favorites/favorites_empty.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

import '../widgets/favorites/favorites_header.dart';
import '../widgets/favorites/favorite_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const FavoritesHeader(),
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  if (state is FavoritesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is FavoritesLoaded) {
                    if (state.isEmpty) {
                      return const FavoritesEmptyState();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(r.spacing(16)),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        return FavoriteCard(
                          favorite: state.favorites[index],
                        );
                      },
                    );
                  }

                  if (state is FavoritesError) {
                    return Center(
                      child: Text('Error: ${state.message}'),
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
}
