import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/cart_state.dart';
import 'package:tartibat/features/customer/widgets/cart/cart_empty.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

import '../widgets/cart/cart_header.dart';
import '../widgets/cart/cart_item_card.dart';
import '../widgets/cart/cart_summary_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const CartHeader(),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CartLoaded) {
                    if (state.isEmpty) {
                      return const CartEmptyState();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(r.spacing(16)),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return CartItemCard(item: state.items[index]);
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoaded && !state.isEmpty) {
                  return const CartSummaryBar();
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
