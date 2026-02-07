import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/localization/app_localizations.dart';
import 'image_picker_section.dart';
import 'product_fields.dart';
import 'save_product_button.dart';

class ProductForm extends StatefulWidget {
  final Map<dynamic, dynamic>? initialData;
  final bool isEdit;
  const ProductForm({super.key, this.initialData, this.isEdit = false});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _price = TextEditingController();
  final _category = TextEditingController();
  final _stock = TextEditingController();
  final _location = TextEditingController();
  final _description = TextEditingController();
  final List<String> _images = [];
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.initialData != null) {
      _name.text = widget.initialData!['name'] ?? '';
      _price.text = widget.initialData!['price']?.toString() ?? '';
      _stock.text = widget.initialData!['stock']?.toString() ?? '';
      _location.text = widget.initialData!['location'] ?? '';
      _description.text = widget.initialData!['description'] ?? '';
      if (widget.initialData!['image'] != null) {
        _images.add(widget.initialData!['image']);
      }
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _category.dispose();
    _stock.dispose();
    _location.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate() || _images.isEmpty) {
      if (_images.isEmpty) _showError('add_at_least_one_image'.tr(context));
      return;
    }
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    Navigator.pop(context);
  }

  void _showError(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      children: [
        ImagePickerSection(
            images: _images,
            onAdd: () =>
                setState(() => _images.add('https://via.placeholder.com/200')),
            onRemove: (i) => setState(() => _images.removeAt(i))),
        const SizedBox(height: 16),
        ProductFields(
            formKey: _formKey,
            name: _name,
            price: _price,
            category: _category,
            stock: _stock,
            location: _location,
            description: _description),
        const SizedBox(height: 20),
        SaveProductButton(
            isLoading: _saving, onPressed: _save, isEdit: widget.isEdit),
        const SizedBox(height: 100),
      ],
    );
  }
}
