import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/localization/app_localizations.dart';
import 'main_navigation_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  final String orderNumber;
  final int totalAmount;

  const OrderSuccessScreen({
    super.key,
    required this.orderNumber,
    required this.totalAmount,
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(r.spacing(AppDimensions.paddingLarge)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width:
                          r.responsive(mobile: 120, tablet: 140, desktop: 160),
                      height:
                          r.responsive(mobile: 120, tablet: 140, desktop: 160),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [AppColors.success, Color(0xFF81C784)]),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.3),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check,
                        size: r.responsive(mobile: 60, tablet: 70, desktop: 80),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: r.spacing(32)),
                    Text(
                      'order_success'.tr(context),
                      style: AppTextStyles.h1(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: r.spacing(16)),
                    Text(
                      'thank_you'.tr(context),
                      style: AppTextStyles.bodyMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: r.spacing(40)),
                    Container(
                      padding:
                          EdgeInsets.all(r.spacing(AppDimensions.paddingLarge)),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusXLarge),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(context, 'order_number'.tr(context),
                              widget.orderNumber, r),
                          Divider(height: r.spacing(24)),
                          _buildInfoRow(context, 'total_amount'.tr(context),
                              '${widget.totalAmount} ${'egp'.tr(context)}', r),
                          Divider(height: r.spacing(24)),
                          _buildInfoRow(
                              context,
                              'estimated_delivery'.tr(context),
                              'delivery_time'.tr(context),
                              r),
                        ],
                      ),
                    ),
                    SizedBox(height: r.spacing(40)),
                    SizedBox(
                      width: double.infinity,
                      height: r.responsive(mobile: 56, tablet: 60, desktop: 64),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CustomerMainLayout()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusLarge),
                          ),
                          elevation: 0,
                        ),
                        child: Text('back_to_home'.tr(context),
                            style: AppTextStyles.buttonStatic),
                      ),
                    ),
                    SizedBox(height: r.spacing(16)),
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${'track_order'.tr(context)} - ${'coming_soon'.tr(context)}'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      child: Text(
                        'track_order'.tr(context),
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                AppColors.primary,
                AppColors.primaryLight,
                AppColors.success,
                AppColors.warning,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, Responsive r) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmall(context)),
        Text(
          value,
          style: AppTextStyles.bodyMedium(context)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
