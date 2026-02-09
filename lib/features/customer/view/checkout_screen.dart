import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tartibat/features/customer/data/bloc/cart_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/cart_state.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_cubit.dart';
import 'package:tartibat/features/customer/data/bloc/checkout_state.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../widgets/checkout/checkout_header.dart';
import '../widgets/checkout/checkout_order_summary.dart';
import '../widgets/checkout/checkout_address_section.dart';
import '../widgets/checkout/checkout_payment_section.dart';
import '../widgets/checkout/checkout_total_bar.dart';
import '../widgets/checkout/order_success_dialog.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is OrderPlaced) {
          context.read<CartCubit>().clearCart();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => OrderSuccessDialog(order: state.order),
          );
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              const CheckoutHeader(),
              Expanded(
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, cartState) {
                    if (cartState is! CartLoaded || cartState.isEmpty) {
                      return Center(
                        child: Text('Cart is empty'),
                      );
                    }

                    return ListView(
                      padding: EdgeInsets.all(r.spacing(16)),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const CheckoutOrderSummary(),
                        SizedBox(height: r.spacing(16)),
                        const CheckoutAddressSection(),
                        SizedBox(height: r.spacing(16)),
                        const CheckoutPaymentSection(),
                        SizedBox(height: r.spacing(100)),
                      ],
                    );
                  },
                ),
              ),
              const CheckoutTotalBar(),
            ],
          ),
        ),
      ),
    );
  }
}
