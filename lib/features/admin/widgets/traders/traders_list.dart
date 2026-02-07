import 'package:flutter/material.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/localization/app_localizations.dart';
import 'trader_card.dart';

class TradersList extends StatelessWidget {
  final String status;
  final List<Map<String, dynamic>> traders;

  const TradersList({
    super.key,
    required this.status,
    required this.traders,
  });

  @override
  Widget build(BuildContext context) {
    if (traders.isEmpty) {
      return EmptyState(
        icon: Icons.store_outlined,
        title: 'no_traders'.tr(context),
        message: 'no_traders_message'.tr(context),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: traders.length,
      itemBuilder: (context, index) {
        return TraderCard(trader: traders[index], status: status);
      },
    );
  }
}
