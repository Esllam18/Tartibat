import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/common/admin_app_bar.dart';
import '../widgets/traders/traders_list.dart';
import '../widgets/traders/traders_filter_tabs.dart';

class AdminTradersScreen extends StatefulWidget {
  const AdminTradersScreen({super.key});

  @override
  State<AdminTradersScreen> createState() => _AdminTradersScreenState();
}

class _AdminTradersScreenState extends State<AdminTradersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AdminAppBar(title: 'traders'.tr(context)),
      body: Column(
        children: [
          TradersFilterTabs(controller: _tabController),
          Expanded(
            child: _isLoading
                ? const LoadingState()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      TradersList(
                          status: 'pending', traders: _getPendingTraders()),
                      TradersList(
                          status: 'active', traders: _getActiveTraders()),
                      TradersList(
                          status: 'suspended', traders: _getSuspendedTraders()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getPendingTraders() => [];
  List<Map<String, dynamic>> _getActiveTraders() => [];
  List<Map<String, dynamic>> _getSuspendedTraders() => [];
}
