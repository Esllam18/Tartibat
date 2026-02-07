import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ZainCashWebView extends StatelessWidget {
  final String paymentUrl;
  final Function(bool success) onPaymentComplete;

  const ZainCashWebView({
    super.key,
    required this.paymentUrl,
    required this.onPaymentComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZainCash Payment', style: AppTextStyles.h3(context)),
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(color: AppColors.primary),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.payment,
                    size: 80,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Redirecting to ZainCash...',
                    style: AppTextStyles.h4(context),
                  ),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          // WebView(
          //   initialUrl: paymentUrl,
          //   onPageFinished: (url) => _handleCallback(url),
          // ),
        ],
      ),
    );
  }

  // void _handleCallback(String url) {
  //   if (url.contains('success')) {
  //     onPaymentComplete(true);
  //   } else if (url.contains('failed')) {
  //     onPaymentComplete(false);
  //   }
  // }
}
