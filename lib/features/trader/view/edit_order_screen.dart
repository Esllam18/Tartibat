import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/localization/app_localizations.dart';
import '../widgets/order_detail_section.dart';
import '../widgets/order_status_selector.dart';
import '../widgets/order_notes_field.dart';
import '../widgets/update_order_button.dart';

class EditOrderScreen extends StatefulWidget {
  final Map<String, dynamic> order;
  const EditOrderScreen({super.key, required this.order});

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  late String _status;
  final _notes = TextEditingController();
  bool _updating = false;

  @override
  void initState() {
    super.initState();
    _status = widget.order['status'] ?? 'new';
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _update() async {
    setState(() => _updating = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('order_updated'.tr(context)),
        backgroundColor: AppColors.success));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.textPrimary),
              onPressed: () => Navigator.pop(context)),
          title:
              Text('edit_order'.tr(context), style: AppTextStyles.h3(context)),
          centerTitle: true),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: [
          OrderDetailSection(order: widget.order),
          const SizedBox(height: 16),
          OrderStatusSelector(
              current: _status, onChanged: (v) => setState(() => _status = v)),
          const SizedBox(height: 16),
          OrderNotesField(controller: _notes),
          const SizedBox(height: 24),
          UpdateOrderButton(isLoading: _updating, onPressed: _update),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
